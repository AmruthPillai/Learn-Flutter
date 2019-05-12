import 'package:flutter/material.dart';

import 'package:learn_flutter/products.dart';

class ProductManager extends StatefulWidget {
  final String startingProduct;

  ProductManager(this.startingProduct) {
    print('[ProductManager Widget] Constructor');
  }

  @override
  _ProductManagerState createState() {
    print('[ProductManager Widget] createState()');
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = [];

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

  @override
  Widget build(BuildContext context) {
    print('[ProductManager State] build()');
    return Column(children: <Widget>[
      Container(
        margin: EdgeInsets.all(10.0),
        child: RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text('Add Product'),
          onPressed: () {
            setState(() => _products.add('Advanced Food Tester'));
          },
        ),
      ),
      Products(_products)
    ]);
  }
}
