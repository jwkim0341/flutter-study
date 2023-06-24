import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:section1/common/model/cursor_pagination_model.dart';
import 'package:section1/common/model/pagination_params.dart';
import 'package:section1/rating/model/rating_model.dart';

part 'restaurant_rating_repository.g.dart';

// http://ip/restaurant/:rid/rating
@RestApi()
abstract class RestaurantRatingRepository{
  factory RestaurantRatingRepository(Dio dio,{String baseUrl})=
      _RestaurantRatingRepository;

  @GET('/')
  @Headers({'accessToken':'true',})
  Future<CursorPagination<RatingModel>> paginate({
  @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}