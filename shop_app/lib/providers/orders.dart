import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> items;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.items,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  static List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  Future<void> fetchOrders() async {
    final String url = 'https://flutter-shopify.firebaseio.com/orders.json';
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;
    final List<OrderItem> orders = [];
    if (data == null) return;
    data.forEach((id, order) {
      orders.add(OrderItem(
        id: id,
        amount: order['amount'],
        dateTime: DateTime.parse(order['dateTime']),
        items: (order['items'] as List<dynamic>)
            .map((item) => CartItem(
                  id: item['id'],
                  product: Products().findById(item['product']),
                  quantity: item['quantity'],
                ))
            .toList(),
      ));
    });
    _orders = orders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> items, double amount) async {
    final String url = 'https://flutter-shopify.firebaseio.com/orders.json';
    final timestamp = DateTime.now();

    final response = await http.post(
      url,
      body: json.encode({
        'amount': amount,
        'items': items
            .map((cp) => {
                  'id': cp.id,
                  'quantity': cp.quantity,
                  'product': cp.product.id,
                })
            .toList(),
        'dateTime': timestamp.toIso8601String(),
      }),
    );

    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: amount,
        items: items,
        dateTime: timestamp,
      ),
    );
    notifyListeners();
  }
}
