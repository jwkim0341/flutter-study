import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:section1/common/const/data.dart';
import 'package:section1/user/model/user_model.dart';
import 'package:section1/user/repository/user_me_repository.dart';

class UserMeStateNorifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  UserMeStateNorifier({
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    // 내 정보 가져오기
    getMe();
  }

  getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accesshToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if(refreshToken == null || accesshToken == null){
      state = null;
      return;
    }

    // 토큰이 존재한다는 가정하에 보낼 수 있음
    final resp = await repository.getMe();
    state = resp;
  }
}
