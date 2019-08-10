import 'package:flutter/material.dart';
import 'package:learn_flutter/models/user.dart';
import 'package:learn_flutter/scoped_models/connected_products.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends ConnectedProducts {
  static UserModel of(BuildContext context) =>
      ScopedModel.of<UserModel>(context, rebuildOnChange: true);

  void login(String email, String password) {
    authenticatedUser = User(
      id: '1d60c36f-732a-4385-9a5c-0790e9f912b2',
      email: email,
      password: password,
    );
    notifyListeners();
  }
}
