import 'package:flutter/material.dart';
import 'package:learn_flutter/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductsModel extends Model {
  int _selectedProductIndex;
  final List<Product> _products = [];

  static ProductsModel of(BuildContext context) =>
      ScopedModel.of<ProductsModel>(context);

  List<Product> get products => List.from(_products);
  int get selectedProductIndex => _selectedProductIndex;

  Product get selectedProduct {
    return (_selectedProductIndex == null)
        ? null
        : _products[_selectedProductIndex];
  }

  void addProduct(Product product) {
    _products.add(product);
    _selectedProductIndex = null;
  }

  void updateProduct(Product product) {
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
  }

  void deleteProduct() {
    _products.removeAt(_selectedProductIndex);
    _selectedProductIndex = null;
  }

  void selectProduct(int index) {
    _selectedProductIndex = index;
  }
}
