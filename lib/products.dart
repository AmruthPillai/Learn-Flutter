import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  final List<String> products;

  Products({this.products = const []}) {
    print('[Products Widget] Constructor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
        child: Column(children: <Widget>[
      Image.asset('assets/food.jpg'),
      Text(products[index])
    ]));
  }

  Widget _buildProductList() {
    if (products.length > 0) {
      return ListView.builder(
        itemBuilder: _buildProductItem,
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
    print('[Products Widget] build()');
    return _buildProductList();
  }
}
