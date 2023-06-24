import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:section1/common/model/cursor_pagination_model.dart';
import 'package:section1/common/provider/pagination_provider.dart';
import 'package:section1/rating/model/rating_model.dart';
import 'package:section1/restaurant/repository/restaurant_rating_repository.dart';

final restaurantRatingProvider = StateNotifierProvider.family<
    RestaurantRatingsStateNotifier, CursorPaginationBase, String>((ref, id) {
  final repo = ref.watch(restaurantRatingRepositoryProvider(id));
  return RestaurantRatingsStateNotifier(repository: repo);
});

class RestaurantRatingsStateNotifier
    extends PaginationProvider<RatingModel, RestaurantRatingRepository> {
  RestaurantRatingsStateNotifier({
    required super.repository,
  });
}
