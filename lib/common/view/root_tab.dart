import 'package:flutter/material.dart';
import 'package:section1/common/const/colors.dart';
import 'package:section1/common/layout/default_layout.dart';
import 'package:section1/product/view/product_screen.dart';
import 'package:section1/restaurant/view/restaurant_screen.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;
  //나중에 값이 입력이 될건데 부를 때는 controller라는 값은 이미 선언이 되어있을거라는 뜻

  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = TabController(length: 4, vsync: this);
    // 컨트롤러의 변화가 있을 때마다 tabListener 함수를 부른다
    controller.addListener(tabListener);
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);
    // TODO: implement dispose
    super.dispose();
  }

  void tabListener(){
    setState(() {
      index = controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코팩 딜리버리',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(), //스크롤바는 고정, 탭바를 통해서만 이동
        controller: controller,
        children: [
          RestaurantScreen(),
          ProductScreen(),
          Center(child: Container(child: Text('주문'),)),
          Center(child: Container(child: Text('프로필'),)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
         controller.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fastfood_outlined,
            ),
            label: '음식',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt_long_outlined,
            ),
            label: '주문',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outlined,
            ),
            label: '프로필',
          ),
        ],
      ),
    );
  }
}
