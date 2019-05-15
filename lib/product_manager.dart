import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/products/products.dart';

class ProductManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: Products(),
      )
    ]);
  }
}
