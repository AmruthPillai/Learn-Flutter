import 'package:flutter/material.dart';
import 'package:learn_flutter/pages/product.dart';

class Products extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function deleteProduct;

  Products({this.products, this.deleteProduct}) {
    print('[Products Widget] Constructor');
  }

  Widget _buildProductItem(BuildContext context, int index) {
    return Card(
        child: Column(children: <Widget>[
      Image.asset(products[index]['imageUrl']),
      Text(products[index]['title']),
      ButtonBar(
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Text('Details'),
            onPressed: () => Navigator.pushNamed<bool>(
                        context, '/product/' + index.toString())
                    .then((bool value) {
                  if (value) {
                    deleteProduct(index);
                  }
                }),
          ),
        ],
      )
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
