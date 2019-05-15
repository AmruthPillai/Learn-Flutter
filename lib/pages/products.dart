import 'package:flutter/material.dart';
import 'package:learn_flutter/product_manager.dart';
import 'package:learn_flutter/scoped_models/products.dart';

class ProductsPage extends StatelessWidget {
  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Choose'),
          ),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/admin');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildSideDrawer(context),
      appBar: AppBar(
        title: Text('EasyList'),
        actions: <Widget>[
          IconButton(
            icon: Icon(ProductsModel.of(context).showFavorites
                ? Icons.favorite
                : Icons.favorite_border),
            onPressed: () {
              ProductsModel.of(context).toggleDisplayMode();
            },
          ),
        ],
      ),
      body: ProductManager(),
    );
  }
}
