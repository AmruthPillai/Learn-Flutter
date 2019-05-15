import 'package:flutter/material.dart';
import 'package:learn_flutter/models/product.dart';
import 'package:learn_flutter/scoped_models/products.dart';
import 'package:learn_flutter/widgets/products/product_card.dart';

class Products extends StatelessWidget {
  Widget _buildProductList(List<Product> products) {
    if (products.length > 0) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            ProductCard(products[index], index),
        itemCount: products.length,
      );
    } else {
      return Center(
        child: Text('No Products Found, please add some!'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildProductList(ProductsModel.of(context).products);
  }
}
