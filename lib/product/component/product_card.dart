import 'package:flutter/material.dart';
import 'package:section1/common/const/colors.dart';
import 'package:section1/product/model/product_model.dart';
import 'package:section1/restaurant/model/restaurant_detail_model.dart';

class ProductCard extends StatelessWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;

  const ProductCard(
      {required this.image,
      required this.name,
      required this.detail,
      required this.price,
      super.key});

  factory ProductCard.fromProductModel({
    required ProductModel model,
}){
    return ProductCard(
      image: Image.network(
        model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
      ),
      name: model.name,
      detail: model.detail,
      price: model.price,
    );
  }

  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel model,
  }) {
    return ProductCard(
        image: Image.network(
          model.imgUrl,
        width: 110,
        height: 110,
        fit: BoxFit.cover,
        ),
        name: model.name,
        detail: model.detail,
        price: model.price,
    );
  }


  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: image,
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  detail,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: BODY_TEXT_COLOR,
                  ),
                ),
                Text(
                  price.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: PRIMARY_COLOR,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
