import 'package:flutter/material.dart';
import 'package:learn_flutter/scoped_models/user.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'accept_terms': false
  };

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
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email Address'),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email Address is required!';
        } else if (!RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$')
            .hasMatch(value)) {
          return 'This does not seem to be a valid email address.';
        }
      },
      textInputAction: TextInputAction.next,
      onSaved: (String v) => _formData['email'] = v,
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required!';
        } else if (value.length < 6) {
          return 'The password seems to be less than 6 characters.';
        }
      },
      textInputAction: TextInputAction.done,
      onSaved: (String v) => _formData['password'] = v,
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
      value: _formData['accept_terms'],
      onChanged: (bool value) =>
          setState(() => _formData['accept_terms'] = value),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    UserModel.of(context).login(_formData['email'], _formData['password']);
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
                child: Form(
                  key: _formKey,
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
      ),
    );
  }
}
