import 'package:learn_flutter/models/product.dart';
import 'package:learn_flutter/models/user.dart';
import 'package:scoped_model/scoped_model.dart';

class ConnectedProducts extends Model {
  List<Product> products = [];
  User authenticatedUser;
  int selProductIndex;
}
