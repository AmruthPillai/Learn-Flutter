import 'package:flutter/foundation.dart';
import 'package:shop_app/providers/cart.dart';

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
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  void addOrder(List<CartItem> items, double amount) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: amount,
        items: items,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
