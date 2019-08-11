import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/edit_product_page.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/main_drawer.dart';
import 'package:shop_app/widgets/user_product_card.dart';

class UserProductsPage extends StatelessWidget {
  static const String routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsStore = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Products'),
        actions: <Widget>[
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductPage.routeName),
            icon: Icon(Icons.add),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsStore.items.length,
          itemBuilder: (ctx, idx) => Column(
            children: <Widget>[
              UserProductCard(
                productsStore.items[idx].id,
                productsStore.items[idx].title,
                productsStore.items[idx].imageUrl,
                () {
                  productsStore.deleteProduct(productsStore.items[idx].id);
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
