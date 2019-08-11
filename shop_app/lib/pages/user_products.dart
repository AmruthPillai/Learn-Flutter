import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/edit_product_page.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/main_drawer.dart';
import 'package:shop_app/widgets/user_product_card.dart';

class UserProductsPage extends StatelessWidget {
  static const String routeName = '/user-products';

  Future<void> _refreshProducts(context) async {
    await Provider.of<Products>(context).fetchProducts();
  }

  Future<void> _deleteProduct(context, productsStore, index) async {
    try {
      await productsStore.deleteProduct(productsStore.items[index].id);
    } catch (e) {
      Scaffold.of(context).showSnackBar(
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
    final productsStore = Provider.of<Products>(context);
    final _scaffold = GlobalKey();

    return Scaffold(
      key: _scaffold,
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
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsStore.items.length,
            itemBuilder: (ctx, idx) => Column(
              children: <Widget>[
                Builder(
                  builder: (ctx) => UserProductCard(
                    productsStore.items[idx].id,
                    productsStore.items[idx].title,
                    productsStore.items[idx].imageUrl,
                    () => _deleteProduct(
                        _scaffold.currentContext, productsStore, idx),
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}