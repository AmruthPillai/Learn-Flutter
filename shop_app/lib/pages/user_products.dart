import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/edit_product_page.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/main_drawer.dart';
import 'package:shop_app/widgets/user_product_card.dart';

class UserProductsPage extends StatelessWidget {
  static const String routeName = '/user-products';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> _refreshProducts(context) async {
    await Provider.of<Products>(context, listen: false).fetchProducts(true);
  }

  Future<void> _deleteProduct(productsStore, index) async {
    try {
      await productsStore.deleteProduct(productsStore.items[index].id);
    } catch (e) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            'Something went wrong!',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      body: FutureBuilder<Object>(
        future: _refreshProducts(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ));
          }
          return RefreshIndicator(
            onRefresh: () => _refreshProducts(context),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Consumer<Products>(
                builder: (ctx, productsStore, child) => ListView.builder(
                  itemCount: productsStore.items.length,
                  itemBuilder: (ctx, idx) => Column(
                    children: <Widget>[
                      Builder(
                        builder: (ctx) => UserProductCard(
                          productsStore.items[idx].id,
                          productsStore.items[idx].title,
                          productsStore.items[idx].imageUrl,
                          () => _deleteProduct(productsStore, idx),
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
