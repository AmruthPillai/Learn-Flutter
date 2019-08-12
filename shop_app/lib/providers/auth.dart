import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  static String _token;
  static String _userId;
  static DateTime _expiryDate;
  Timer _authTimer;

  bool get isAuth => token != null;

  static String get userId => _userId;

  static String get token {
    if (_expiryDate != null &&
        _token != null &&
        _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  Future<void> _storeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = json.encode({
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate.toIso8601String(),
    });
    prefs.setString('auth', authData);
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

    _storeAuthData();
    _autoLogout();
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

    _storeAuthData();
    _autoLogout();
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('auth')) return false;

    final authData = json.decode(prefs.getString('auth'));
    final expiryDate = DateTime.parse(authData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) return false;

    _token = authData['token'];
    _userId = authData['userId'];
    _expiryDate = DateTime.parse(authData['expiryDate']);

    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.remove('auth');
  }

  void _autoLogout() {
    if (_authTimer != null) _authTimer.cancel();
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
