import 'package:flutter/material.dart';
import 'package:learn_flutter/pages/products_admin.dart';
import 'package:learn_flutter/product_manager.dart';

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('Choose'),
            ),
            ListTile(
              title: Text('Manage Products'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductsAdminPage(),
                    ));
              },
            )
          ],
        ),
      ),
      appBar: AppBar(title: Text('EasyList')),
      body: ProductManager(),
    );
  }
}
