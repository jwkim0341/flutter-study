import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:section1/user/model/user_model.dart';
import 'package:section1/user/provider/user_me_provider.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(
      userMeProvider,
      (previous, next) {
        if(previous != next){
          notifyListeners();
        }
      },
    );
  }

  // SplashScreen
  // 앱을 처음 시작했을 때
  // 토큰이 존재하는지 확인하고
  // 로그인 스크린으로 보내줄지
  // 홈 스크린으로 보내줄지 확인하는 과정이 필요하다.
  String? redirectLogic(GoRouterState state){
    final UserModelBase? user = ref.read(userMeProvider);

    final loginIn = state.location == '/login';

    // 유저 정보가 없는데
    // 로그인 중이면 그대로 로그인 페이지에 두고
    // 만약에 로그인 중이 아니라면 로그인 페이지로 이동
    if(user == null){
      return loginIn ? null:'/login';
    }

    // user가 null 아님

    // UserModel
    // 사용자 정보가 있는 상태면
    // 로그인 중이거나 현재 위치가 SplashScreen이면
    // 홈으로 이동
    if(user is UserModel){
      return loginIn || state.location == '/splash' ? '/' : null;
    }

    // UserModelError
    if(user is UserModelError){
      return !loginIn ? '/login' : null;
    }

    return null; // 원래 가던 곳으로 가세요
  }
}
