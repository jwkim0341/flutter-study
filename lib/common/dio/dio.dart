import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:section1/common/const/data.dart';
import 'package:section1/common/secure_storage/secure_storage.dart';

final dioProvider = Provider<Dio>((ref){
  final dio = Dio();

  final storage = ref.watch(secureStorageProvider);

  //프로바이더 안에서 생성한 securestorage 사용
  dio.interceptors.add(
    CustomInterceptor(storage: storage),
  );
  return dio;
});

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({required this.storage});

  // 1. 요청을 보낼 때
  // 요청이 보내질때마다
  // 만약에 요청이 Headder에 accessToken: true라는 값이 있다면
  // 실제 토큰을 가져와서 (storage에서) authorization: bearer $token으로
  // header를 변경한다.
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');
    // 헤더 삭제
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');

      final token = await storage.read(key: ACCESS_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      options.headers.remove('refreshToken');

      final token = await storage.read(key: REFRESH_TOKEN_KEY);

      // 실제 토큰으로 대체
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }

    return super.onRequest(options, handler);
  }

  // 2. 응답을 받을 때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');
    super.onResponse(response, handler);
  }
  // 3. 에러가 났을 때
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // 401에러가 났을때 (status code)
    // 토큰을 재발급 받는 시도를 하고 토큰이 재발급되면
    // 다시 새로운 토큰으로 요청을 한다.
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');

    final refreshToekn = await storage.read(key: REFRESH_TOKEN_KEY);

    // refreshToken이 아예 없으면
    // 당연히 에러를 던진다
    if (refreshToekn == null) {
      // 에러를 던질 때는 handler.reject를 사용한다.
      return handler.reject(err);
    }

    // 상태가 401인지 확인 변수
    // 응답의 모든 것을 가져올 수 있음 - response
    // 응답이 없을 수도 있기 때문에 ? 붙여줌
    final isStatus401 = err.response?.statusCode == 401;

    // 토큰을 refresh하려다가 에러가 났는지 확인하는 변수
    // 요청이 저 url로 갔는지 확인하는 것 - requestOptions
    // true - 어차피 원래 accessToken을 위해 발급받으려다가
    // refreshToken 자체에 문제가 있었다는 의미
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    // 토큰을 새로 refresh 하려던 의도가 아니였느데 근데 401 에러가 났다면?
    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();


      try {
        // 새로운 access token 발급
        final resp = await dio.post(
          'http://$ip/auth/token',
          options: Options(
            headers: {
              'authorization': 'Bearer $refreshToekn',
            },
          ),
        );

        // 에러가 안났을 때 token 얼어올 수 있음
        final accessToken = resp.data['accessToken'];

        // 요청페이지의 헤더의 옵션 (onrequest의 옵션)
        // 에러를 발생시킨 모든 요청과 관련된 옵션이다
        final options = err.requestOptions;

        // 토큰 변경하기
        // 헤더에 토큰을 대체해줌
        options.headers.addAll({'authorization': 'Bearer $accessToken'});
        // 새로 발급받았으니 storage도 update 해줌
        // 안해주게 되면 이번 요청에서만 새로 발급한 토큰 사용하고
        // 다음 요청에서는 원래 저장되어있던 걸로 사용하게 된다
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // 요청 재전송 - fetch 사용 시 requestOptions이 들어가는데
        // 여기서는 새로 발급받은 걸로 options을 만들었으니 그것으로 대체
        final response = await dio.fetch(options);

        // 실제로는 응답이 잘 왔다고 되돌려줘야함
        // 새로 보낸 응답의 요청을 보내준다
        return handler.resolve(response);

      } on DioError catch (e) { // dio erro만 따로 잡아줄 수 있음
        // 어떤 이유에서든 에러가 났을 때 token refresh 할 수 있는 상황이 아님
        // refresh toekn의 상태가 잘못됐다고 판단하면 그냥 에러 던져줌
        return handler.reject(e);
      }
    }
    return handler.reject(err);
  }
}
