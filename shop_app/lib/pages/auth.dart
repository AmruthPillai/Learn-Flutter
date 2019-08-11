import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  static const String routeName = '/auth';

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var _isInLoginMode = true;

  void toggleMode() {
    setState(() => _isInLoginMode = !_isInLoginMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _isInLoginMode ? LoginCard(toggleMode) : SignupCard(toggleMode),
          ],
        ),
      ),
    );
  }
}

class SignupCard extends StatelessWidget {
  final Function toggleMode;
  final GlobalKey<FormState> _form = GlobalKey();
  final _emailAddressCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  SignupCard(this.toggleMode);

  void _onSave() {
    var result = _form.currentState.validate();
    if (!result) return;
    _form.currentState.save();
    print(_emailAddressCtrl.text);
    print(_passwordCtrl.text);
    print(_confirmPasswordCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 30,
                    bottom: 10,
                  ),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _emailAddressCtrl,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter an email address.';
                            }
                            if (!value.contains('@')) {
                              return 'This doesn\'t look like a valid email address.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordCtrl,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a password.';
                            }
                            if (value.length < 6) {
                              return 'Password should be at least 6 characters long.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _confirmPasswordCtrl,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a password.';
                            }
                            if (value.length < 6) {
                              return 'Password should be at least 6 characters long.';
                            }
                            if (value != _passwordCtrl.text) {
                              return 'The passwords seem to be different.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        FlatButton(
                          onPressed: () {
                            _onSave();
                          },
                          textColor: Theme.of(context).primaryColor,
                          child: Text(
                            'SIGNUP',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          FlatButton(
            onPressed: toggleMode,
            textColor: Colors.white,
            child: Text(
              'Already have an account?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginCard extends StatelessWidget {
  final Function toggleMode;
  final GlobalKey<FormState> _form = GlobalKey();
  final _emailAddressCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  void _onSave() {
    var result = _form.currentState.validate();
    if (!result) return;
    _form.currentState.save();
    print(_emailAddressCtrl.text);
    print(_passwordCtrl.text);
  }

  LoginCard(this.toggleMode);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 30,
                    bottom: 10,
                  ),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: _emailAddressCtrl,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter an email address.';
                            }
                            if (!value.contains('@')) {
                              return 'This doesn\'t look like a valid email address.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordCtrl,
                          keyboardType: TextInputType.text,
                          autocorrect: false,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a password.';
                            }
                            if (value.length < 6) {
                              return 'Password should be at least 6 characters long.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        FlatButton(
                          onPressed: () {
                            _onSave();
                          },
                          textColor: Theme.of(context).primaryColor,
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          FlatButton(
            onPressed: toggleMode,
            textColor: Colors.white,
            child: Text(
              'Don\'t have an account?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
