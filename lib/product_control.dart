import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  final Function _addProduct;

  ProductControl(this._addProduct) {
    print('[ProductControl] Constructor');
  }

  @override
  Widget build(BuildContext context) {
    print('[ProductControl] build()');

    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Text('Add Product'),
      onPressed: () => _addProduct({
            'title': 'Chcoolate',
            'imageUrl': 'assets/food.jpg',
          }),
    );
  }
}
