import 'package:json_annotation/json_annotation.dart';
import 'package:section1/common/model/model_with_id.dart';
import 'package:section1/common/utils/data_utils.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange { expensive, medium, cheap }

@JsonSerializable()
class RestaurantModel implements IModelWithId{
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;


  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  //항상 이 패턴대로 코드를 생성한다
  factory RestaurantModel.fromJson(Map<String,dynamic> json)
  => _$RestaurantModelFromJson(json);

  Map<String,dynamic> toJson() => _$RestaurantModelToJson(this);
}
