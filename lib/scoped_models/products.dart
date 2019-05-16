import 'package:flutter/material.dart';
import 'package:learn_flutter/models/product.dart';
import 'package:learn_flutter/scoped_models/connected_products.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsModel extends ConnectedProducts {
  bool _showFavorites = false;

  static ProductsModel of(BuildContext context) =>
      ScopedModel.of<ProductsModel>(context, rebuildOnChange: true);

  List<Product> get allProducts => List.from(products);

  int get selectedProductIndex => selProductIndex;

  bool get showFavorites => _showFavorites;
  List<Product> get displayedProducts {
    return (_showFavorites)
        ? products.where((Product product) => product.isFavorite).toList()
        : List.from(products);
  }

  Product get selectedProduct {
    return (selProductIndex == null) ? null : products[selProductIndex];
  }

  void addProduct(
    String title,
    String description,
    String image,
    double price,
  ) {
    products.add(
      Product(
        title: title,
        description: description,
        image: image,
        price: price,
        userId: '123456',
        userEmail: 'test@test.com',
      ),
    );
    selProductIndex = null;
    notifyListeners();
  }

  void updateProduct(
    String title,
    String description,
    String image,
    double price,
  ) {
    products[selProductIndex] = Product(
      title: title,
      description: description,
      image: image,
      price: price,
      userId: selectedProduct.userId,
      userEmail: selectedProduct.userEmail,
    );
    selProductIndex = null;
    notifyListeners();
  }

  void deleteProduct() {
    products.removeAt(selProductIndex);
    selProductIndex = null;
    notifyListeners();
  }

  void toggleFavorite() {
    products[selProductIndex] = Product(
      title: selectedProduct.title,
      description: selectedProduct.description,
      image: selectedProduct.image,
      price: selectedProduct.price,
      userId: selectedProduct.userId,
      userEmail: selectedProduct.userEmail,
      isFavorite: !selectedProduct.isFavorite,
    );
    selProductIndex = null;
    notifyListeners();
  }

  void selectProduct(int index) {
    selProductIndex = index;
    notifyListeners();
  }

  void toggleDisplayMode() {
    _showFavorites = !_showFavorites;
    notifyListeners();
  }
}
