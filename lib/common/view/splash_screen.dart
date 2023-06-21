import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:section1/common/const/colors.dart';
import 'package:section1/common/layout/default_layout.dart';
import 'package:section1/common/view/root_tab.dart';
import 'package:section1/user/view/login_screen.dart';

import '../const/data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // deleteToken();
    checkToken();
  }

  //토큰 모두 삭제
  void deleteToken() async{
      await storage.deleteAll();
  }

  void checkToken() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    final dio = Dio();

    try{
      final resp = await dio.post('http://$ip/auth/token',
        options: Options(
          headers: {
            'authorization':'Bearer $refreshToken',
          },
        ),
      );

      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (_) => RootTab()),
            (route) => false,
      );
    }catch(e){ //오류(refresh 토큰 만료 및 상태 200 아닐때)가 있다면 login screen으로 이동
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (_) => LoginScreen()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        backgroundColor: PRIMARY_COLOR,
        child: SizedBox(
          width: MediaQuery.of(context).size.width, // 너비 최대로
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
            children: [
              Image.asset(
                'asset/img/logo/logo.png',
                width: MediaQuery.of(context).size.width / 2,
              ),
              SizedBox(
                height: 16.0,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              )
            ],
          ),
        ));
  }
}
