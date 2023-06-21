import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section1/common/const/data.dart';
import 'package:section1/common/dio/dio.dart';
import 'package:section1/common/model/cursor_pagination_model.dart';
import 'package:section1/restaurant/component/restaurant_card.dart';
import 'package:section1/restaurant/model/restaurant_model.dart';
import 'package:section1/restaurant/repository/restaurant_repository.dart';
import 'package:section1/restaurant/view/restaurant_detail_screen.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<CursorPagination<RestaurantModel>>(
            future: ref.watch(restaurantRepositoryProvider).paginate(),
            builder: (context, AsyncSnapshot<CursorPagination<RestaurantModel>> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.separated(
                itemBuilder: (_, index) {
                  final pItem = snapshot.data!.data[index];

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
                itemCount: snapshot.data!.data.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
