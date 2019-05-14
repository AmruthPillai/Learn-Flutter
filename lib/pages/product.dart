import 'dart:async';
import 'package:flutter/material.dart';
import 'package:learn_flutter/widgets/ui_elements/product_title.dart';

class ProductPage extends StatelessWidget {
  final int index;
  final Map<String, dynamic> product;
  final Function deleteProduct;

  ProductPage(this.index, this.product, this.deleteProduct);

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
                    deleteProduct(index);
                    Navigator.pop(context, true);
                  })
            ],
          );
        });
  }

  Widget _buildAddressPriceRow() {
    return Text(
      'Union Square, San Francisco | \$' + product['price'].toString(),
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Oswald',
          color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('Back button pressed!');
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(product['title']),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _showWarningDialog(context),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Image.asset(product['image']),
            SizedBox(height: 10.0),
            ProductTitle(product['title']),
            SizedBox(height: 4.0),
            _buildAddressPriceRow(),
            SizedBox(height: 12.0),
            Text(product['description'])
          ],
        ),
      ),
    );
  }
}
