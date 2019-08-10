import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/pages/cart.dart';
import 'package:shop_app/pages/orders.dart';
import 'package:shop_app/pages/product_detail.dart';
import 'package:shop_app/pages/product_overview.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: Orders()),
        ChangeNotifierProvider.value(value: Cart()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink,
          accentColor: Colors.blue,
          fontFamily: 'Lato',
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(
              title: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.white,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
        home: ProductOverviewPage(),
        routes: {
          ProductOverviewPage.routeName: (ctx) => ProductOverviewPage(),
          ProductDetailPage.routeName: (ctx) => ProductDetailPage(),
          OrdersPage.routeName: (ctx) => OrdersPage(),
          CartPage.routeName: (ctx) => CartPage(),
        },
      ),
    );
  }
}
