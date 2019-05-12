import 'package:flutter/material.dart';
import 'package:learn_flutter/product_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.deepOrange, accentColor: Colors.deepPurple),
        home: Scaffold(
            appBar: AppBar(title: Text('EasyList')),
            body: ProductManager('Food Tester')));
  }
}
