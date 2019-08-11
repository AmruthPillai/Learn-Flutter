import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class CartItem {
  final String id;
  final Product product;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.product,
    @required this.quantity,
  });
}

class Cart with ChangeNotifier {
  static Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  int get cartCount {
    var total = 0;
    _items.forEach((k, v) => total += v.quantity);
    return total;
  }

  double get totalCartValue {
    var total = 0.0;
    _items.forEach((k, v) => total += v.product.price * v.quantity);
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (item) => CartItem(
          id: item.id,
          product: item.product,
          quantity: item.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: DateTime.now().toString(),
          product: product,
          quantity: 1,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (item) => CartItem(
          id: item.id,
          product: item.product,
          quantity: item.quantity - 1,
        ),
      );
    }

    _items.keys
        .where((k) => _items[k].quantity == 0)
        .toList()
        .forEach(_items.remove);

    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
