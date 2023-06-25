import 'package:flutter/material.dart';
import 'package:section1/common/component/pagination_list_view.dart';
import 'package:section1/product/component/product_card.dart';
import 'package:section1/product/model/product_model.dart';
import 'package:section1/product/provider/product_provider.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productPorivder,
      itemBuilder: <ProductModel>(_, index, model) {
        return ProductCard.fromProductModel(
          model: model,
        );
      },
    );
  }
}
