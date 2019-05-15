import 'package:flutter/material.dart';
import 'package:learn_flutter/pages/auth.dart';
import 'package:learn_flutter/pages/product.dart';
import 'package:learn_flutter/pages/products.dart';
import 'package:learn_flutter/pages/products_admin.dart';
import 'package:learn_flutter/scoped_models/products.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ProductsModel>(
      model: ProductsModel(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepPurple,
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.deepPurple,
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/admin': (BuildContext context) => ProductsAdminPage(),
          '/products': (BuildContext context) => ProductsPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');

          if (pathElements[0] != '') return null;

          if (pathElements[1] == 'product') {
            final int index = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(builder: (BuildContext context) {
              return ProductPage(index);
            });
          }

          return null;
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (BuildContext context) {
            return ProductsPage();
          });
        },
      ),
    );
  }
}
