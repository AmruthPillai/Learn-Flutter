import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/product.dart';

class Products with ChangeNotifier {
  static List<Product> _items = [];

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      _items.where((item) => item.isFavorite).toList();

  Product findById(String id) => _items.firstWhere((item) => item.id == id);

  Future<void> fetchProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? '&orderBy="creatorId"&equalTo="${Auth.userId}"' : '';
    var url =
        'https://flutter-shopify.firebaseio.com/products.json?auth=${Auth.token}$filterString';

    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> products = [];

      if (data == null) return;
      if (data['error'] != null) throw data['error'];

      url =
          'https://flutter-shopify.firebaseio.com/userFavorites/${Auth.userId}.json?auth=${Auth.token}';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);

      data.forEach((id, product) {
        products.add(Product(
          id: id,
          title: product['title'],
          description: product['description'],
          price: product['price'],
          imageUrl: product['imageUrl'],
          isFavorite: favoriteData == null ? false : favoriteData[id] ?? false,
        ));
      });
      _items = products;
      notifyListeners();
    } catch (e) {
      // throw e;
      print(e);
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://flutter-shopify.firebaseio.com/products.json?auth=${Auth.token}';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'creatorId': Auth.userId,
        }),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      _items.add(newProduct);
      notifyListeners();
      return Future.value();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);

    if (prodIndex >= 0) {
      final url =
          'https://flutter-shopify.firebaseio.com/products/$id.json?auth=${Auth.token}';
      await http.patch(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
        }),
      );
      _items[prodIndex] = product;
    }

    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://flutter-shopify.firebaseio.com/products/$id.json?auth=${Auth.token}';
    final index = _items.indexWhere((prod) => prod.id == id);
    var product = _items[index];
    _items.removeAt(index);
    notifyListeners();

    var response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(index, product);
      notifyListeners();
      throw 'Error';
    }

    product = null;
  }
}
