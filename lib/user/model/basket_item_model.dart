import 'package:json_annotation/json_annotation.dart';
import 'package:section1/product/model/product_model.dart';

part 'basket_item_model.g.dart';

@JsonSerializable()
class BasketItemModel {
  final ProductModel product;
  final int count;

  BasketItemModel({
    required this.product,
    required this.count,
  });

  //product,count 값을 바꿀거기 때문
  BasketItemModel copyWith({
    ProductModel? product,
    int? count,
  }) {
    return BasketItemModel(
      product: product ?? this.product,
      count: count ?? this.count,
    );
  }

  factory BasketItemModel.fromJson(Map<String, dynamic> json) =>
      _$BasketItemModelFromJson(json);
}
