import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  static String _token;
  static String _userId;
  static DateTime _expiryDate;

  bool get isAuth => token != null;

  static String get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> signup(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyA7ovDPFywh-MpxcmBqaECjN4qZmQkrSdM';

    var response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );

    var responseData = json.decode(response.body);

    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }

    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _expiryDate = DateTime.now().add(Duration(
      seconds: int.parse(responseData['expiresIn']),
    ));

    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    const url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyA7ovDPFywh-MpxcmBqaECjN4qZmQkrSdM';

    var response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );

    var responseData = json.decode(response.body);

    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }

    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _expiryDate = DateTime.now().add(Duration(
      seconds: int.parse(responseData['expiresIn']),
    ));

    notifyListeners();
  }
}
