import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/cart.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/badge.dart';
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
  var _isInit = true;
  var _isLoading = false;
  var _showOnlyFavorites = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _isLoading = true;
      Provider.of<Products>(context)
          .fetchProducts()
          .then((_) => _isLoading = false);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
            ))
          : RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: ProductsGrid(_showOnlyFavorites),
            ),
    );
  }
}
