import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passwordValue;
  bool _acceptTerms = false;

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage('assets/background.jpg'),
      colorFilter: ColorFilter.mode(
        Colors.black.withOpacity(0.5),
        BlendMode.dstATop,
      ),
    );
  }

  Widget _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Email Address'),
      keyboardType: TextInputType.emailAddress,
      onChanged: (String v) => setState(() => _emailValue = v),
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      onChanged: (String v) => setState(() => _passwordValue = v),
    );
  }

  Widget _buildAcceptTermsSwitch() {
    return SwitchListTile(
      title: Text(
        'Accept Terms & Conditions',
        style: TextStyle(
          fontSize: 12.0,
          color: Colors.grey,
        ),
      ),
      value: _acceptTerms,
      onChanged: (bool value) => setState(() => _acceptTerms = value),
    );
  }

  void _submitForm() {
    print(_emailValue);
    print(_passwordValue);
    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildLoginButton() {
    return RaisedButton(
      child: Text('Login'),
      onPressed: _submitForm,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        decoration: BoxDecoration(image: _buildBackgroundImage()),
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0,
                ),
                child: Column(
                  children: <Widget>[
                    _buildEmailTextField(),
                    SizedBox(height: 10.0),
                    _buildPasswordTextField(),
                    SizedBox(height: 5.0),
                    _buildAcceptTermsSwitch(),
                    SizedBox(height: 5.0),
                    _buildLoginButton()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
