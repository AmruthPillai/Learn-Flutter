import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _emailValue;
  String _passwordValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Email Address'),
              keyboardType: TextInputType.emailAddress,
              onChanged: (String v) => setState(() => _emailValue = v),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (String v) => setState(() => _passwordValue = v),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColo
            )
          ],
        ));
  }
}
