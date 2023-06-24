import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section1/common/const/data.dart';
import 'package:section1/common/dio/dio.dart';
import 'package:section1/common/model/cursor_pagination_model.dart';
import 'package:section1/restaurant/component/restaurant_card.dart';
import 'package:section1/restaurant/model/restaurant_model.dart';
import 'package:section1/restaurant/provider/restaurant_provider.dart';
import 'package:section1/restaurant/repository/restaurant_repository.dart';
import 'package:section1/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerStatefulWidget {
  const RestaurantScreen({super.key});

  @override
  ConsumerState<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends ConsumerState<RestaurantScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    controller.addListener(scrollListener);
  }

  void scrollListener(){
    // 현재 위치가
    // 최대 길이보다 조금 덜되는 위치까지 왔다면
    // 새로운 데이터 추가 요청
    if(controller.offset > controller.position.maxScrollExtent - 300){
      ref.read(restaurantProvider.notifier).paginate(
        fetchMore: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(restaurantProvider);

    // 완전 처음 로딩일 때
    if(data is CursorPaginationLoading){
      return Center(child: CircularProgressIndicator(),);
    }

    // 에러
    if(data is CursorPaginationError){
      return Center(
        child: Text(data.message),
      );
    }

    // Cursorpagination
    // CursorpaginationFetchingMore
    // CursorpaginationRefetching

    final cp = data as CursorPagination;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        controller: controller,
        itemCount: cp.data.length,
        itemBuilder: (_, index) {
          final pItem =  cp.data[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RestaurantDetailScreen(
                    id: pItem.id,
                  ),
                ),
              );
            },
            child: RestaurantCard.fromModel(
              model: pItem,
            ),
          );
        },
        separatorBuilder: (_, index) {
          return SizedBox(
            height: 16.0,
          );
        },

      ),
    );
  }
}
