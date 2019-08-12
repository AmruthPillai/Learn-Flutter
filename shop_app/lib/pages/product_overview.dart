import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/cart.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/loading_spinner.dart';
import 'package:shop_app/widgets/main_drawer.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilterOptions {
  All,
  OnlyFavorites,
}

class ProductOverviewPage extends StatefulWidget {
  static const String routeName = '/product-overview';

  @override
  _ProductOverviewPageState createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {
  var _showOnlyFavorites = false;

  Future<void> _refreshProducts(context) async {
    await Provider.of<Products>(context).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopify'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                if (value == FilterOptions.OnlyFavorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.filter_list),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                child: Text('Show All Products'),
                value: FilterOptions.All,
              ),
              PopupMenuItem(
                child: Text('Show Only Favorites'),
                value: FilterOptions.OnlyFavorites,
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, CartPage.routeName),
        backgroundColor: Theme.of(context).primaryColor,
        child: Consumer<Cart>(
          builder: (ctx, cart, child) => Badge(
            value: cart.cartCount > 0 ? cart.cartCount.toString() : null,
            child: child,
          ),
          child: IconButton(
            onPressed: () => Navigator.pushNamed(context, CartPage.routeName),
            icon: Icon(Icons.shopping_cart),
          ),
        ),
      ),
      drawer: MainDrawer(),
      body: FutureBuilder(
        future: Provider.of<Products>(context, listen: false).fetchProducts(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return LoadingSpinner();
          } else {
            if (dataSnapshot.hasError) {
              return Center(
                child: Text('Something went wrong!'),
              );
            }
            return RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: ProductsGrid(_showOnlyFavorites),
            );
          }
        },
      ),
    );
  }
}
