import 'package:json_annotation/json_annotation.dart';
import 'package:section1/common/model/model_with_id.dart';
import 'package:section1/common/utils/data_utils.dart';
import 'package:section1/user/model/user_model.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel implements IModelWithId{
  final String id;
  final UserModel user;
  final int rating;
  final String content;
  // 리스트를 집어넣어서 리스트를 반환
  @JsonKey(
    fromJson: DataUtils.listPathsToUrls,
  )
  final List<String> imgUrl;

  RatingModel({
  required this.id,
  required this.user,
  required this.rating,
  required this.content,
  required this.imgUrl,
 });
  
  factory RatingModel.fromJson(Map<String,dynamic>json)
  => _$RatingModelFromJson(json);
}