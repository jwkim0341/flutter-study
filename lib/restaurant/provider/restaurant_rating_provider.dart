import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section1/common/model/cursor_pagination_model.dart';
import 'package:section1/restaurant/repository/restaurant_rating_repository.dart';

class RestaurantRatingsStateNotifier extends StateNotifier<CursorPaginationBase>{
  final RestaurantRatingRepository repository;

  RestaurantRatingsStateNotifier({
    required this.repository,
}): super(
    CursorPaginationLoading(),
  );

}