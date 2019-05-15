import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learn_flutter/models/product.dart';
import 'package:learn_flutter/scoped_models/products.dart';
import 'package:learn_flutter/widgets/ui_elements/product_title.dart';

class ProductPage extends StatelessWidget {
  final int index;

  ProductPage(this.index);

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('This action cannot be undone.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Discard'),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                  child: Text('Continue'),
                  onPressed: () {
                    Navigator.pop(context);
                    ProductsModel.of(context).selectProduct(index);
                    ProductsModel.of(context).deleteProduct();
                    Navigator.pop(context, true);
                  })
            ],
          );
        });
  }

  Widget _buildAddressPriceRow(double price) {
    return Text(
      'Union Square, San Francisco | \$' + price.toString(),
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Oswald',
          color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Product product = ProductsModel.of(context).products[index];

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(product.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _showWarningDialog(context),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Image.asset(product.image),
            SizedBox(height: 10.0),
            ProductTitle(product.title),
            SizedBox(height: 4.0),
            _buildAddressPriceRow(product.price),
            SizedBox(height: 12.0),
            Text(product.description)
          ],
        ),
      ),
    );
  }
}
