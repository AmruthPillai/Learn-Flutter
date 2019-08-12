import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/widgets/login_card.dart';
import 'package:shop_app/widgets/signup_card.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = '/auth';

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var _isInLoginMode = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _toggleAuthMode() {
    setState(() => _isInLoginMode = !_isInLoginMode);
  }

  Future<void> _authenticate(String email, String password) async {
    try {
      if (_isInLoginMode) {
        await Provider.of<Auth>(context, listen: false).login(email, password);
      } else {
        await Provider.of<Auth>(context, listen: false).signup(email, password);
      }
    } catch (e) {
      var errorMessage = 'Authentication Failed';

      if (e.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (e.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email is already in use.';
      } else if (e.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'The password is too weak.';
      } else if (e.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }

      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Shopify',
              style: TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _isInLoginMode
                ? LoginCard(
                    _toggleAuthMode,
                    _authenticate,
                  )
                : SignupCard(
                    _toggleAuthMode,
                    _authenticate,
                  ),
          ],
        ),
      ),
    );
  }
}
