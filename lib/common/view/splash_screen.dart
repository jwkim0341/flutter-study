import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section1/common/const/colors.dart';
import 'package:section1/common/layout/default_layout.dart';
import 'package:section1/common/secure_storage/secure_storage.dart';
import 'package:section1/common/view/root_tab.dart';
import 'package:section1/user/view/login_screen.dart';

import '../const/data.dart';

class SplashScreen extends ConsumerWidget {
  static String get routeName => 'splash';

  @override
  Widget build(BuildContext context,WidgetRef ref) {
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
