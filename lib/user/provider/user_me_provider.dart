import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:section1/common/const/data.dart';
import 'package:section1/common/secure_storage/secure_storage.dart';
import 'package:section1/user/model/user_model.dart';
import 'package:section1/user/provider/auth_provider.dart';
import 'package:section1/user/repository/auth_repository.dart';
import 'package:section1/user/repository/user_me_repository.dart';

final userMeProvider = StateNotifierProvider<UserMeStateNotifier,UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);

  return UserMeStateNotifier(
    authRepository: authRepository,
    repository: userMeRepository,
    storage: storage,
  );
});

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    // 내 정보 가져오기
    getMe();
  }

  getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accesshToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null || accesshToken == null) {
      state = null;
      return;
    }

    // 토큰이 존재한다는 가정하에 보낼 수 있음
    final resp = await repository.getMe();
    state = resp;
  }

  Future<UserModelBase> login({
    required String username,
    required String password,
  }) async {
    try {
      // 로그인을 시도하자 마자 로딩상태로 반환
      state = UserModelLoading();

      final resp = await authRepository.login(
        username: username,
        password: password,
      );

      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      final userResp = await repository.getMe();
      state = userResp;
      return userResp;
    } catch (error) {
      state = UserModelError(message: '로그인에 실패했습니다.');
      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null;
    // 동시에 실행하고 싶을 때
    await Future.wait([
      storage.delete(key: REFRESH_TOKEN_KEY),
      storage.delete(key: ACCESS_TOKEN_KEY),
    ]);
  }
}
