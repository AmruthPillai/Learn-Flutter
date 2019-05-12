import 'package:flutter/material.dart';
import 'package:learn_flutter/product_control.dart';

import 'package:learn_flutter/products.dart';

class ProductManager extends StatefulWidget {
  final String startingProduct;

  ProductManager({this.startingProduct = 'Sweets Tester'}) {
    print('[ProductManager Widget] Constructor');
  }

  @override
  _ProductManagerState createState() {
    print('[ProductManager Widget] createState()');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  final List<String> _products = [];

  @override
  void initState() {
    super.initState();
    print('[ProductManager State] initState()');
    _products.add(widget.startingProduct);
  }

  @override
  void didUpdateWidget(ProductManager oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('[ProductManager State] didUpdateWidget()');
  }

  void _addProduct(String product) {
    setState(() => _products.add(product));
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductManager State] build()');
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.all(10.0),
        child: ProductControl(_addProduct),
      ),
      Products(products: _products),
    ]);
  }
}
