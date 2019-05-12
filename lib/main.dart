import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> _products = ['Food Tester'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: Text('EasyList')),
          body: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: RaisedButton(
                child: Text('Add Product'),
                onPressed: () {
                  setState(() => _products.add('Advanced Food Tester'));
                },
              ),
            ),
            Column(
                children: _products
                    .map((elem) => Card(
                            child: Column(children: <Widget>[
                          Image.asset('assets/food.jpg'),
                          Text(elem)
                        ])))
                    .toList())
          ])),
    );
  }
}
