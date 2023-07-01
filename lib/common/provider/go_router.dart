import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:section1/user/provider/auth_provider.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    // watch - 값이 변경될 때 마다 다시 빌드
    // read - 한번만 읽고 값이 변경돼도 다시 빌드하지 않음
    final provider = ref.read(authProvider);
    // -> 항상 똑같은 go router 인스턴스를 반환해야함!

    return GoRouter(
      routes: provider.routes,
      initialLocation: '/splash',
      refreshListenable: provider,
      redirect: provider.redirectLogic,
    );
  },
);
