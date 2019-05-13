import 'package:flutter/material.dart';
import 'package:learn_flutter/product_control.dart';
import 'package:learn_flutter/products.dart';

class ProductManager extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;

  ProductManager(this.products, this.addProduct, this.deleteProduct);

  @override
  Widget build(BuildContext context) {
    print('[ProductManager State] build()');
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.all(10.0),
        child: ProductControl(addProduct),
      ),
      Expanded(
        child: Products(products: products, deleteProduct: deleteProduct),
      )
    ]);
  }
}
