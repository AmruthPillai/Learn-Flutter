import 'package:flutter/material.dart';
import 'package:shop_app/widgets/loading_spinner.dart';

class SignupCard extends StatefulWidget {
  final Function toggleMode;
  final Function authenticate;

  SignupCard(this.toggleMode, this.authenticate);

  @override
  _SignupCardState createState() => _SignupCardState();
}

class _SignupCardState extends State<SignupCard> {
  var _isLoading = false;

  final GlobalKey<FormState> _form = GlobalKey();
  final _emailAddressCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  Future<void> _onSave(context) async {
    var result = _form.currentState.validate();
    if (!result) return;
    _form.currentState.save();

    final Map<String, String> formData = {
      'email': _emailAddressCtrl.text,
      'password': _passwordCtrl.text,
    };

    setState(() => _isLoading = true);
    await widget.authenticate(formData['email'], formData['password']);
    setState(() => _isLoading = false);
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
                        _isLoading
                            ? Padding(
                                padding: const EdgeInsets.all(10),
                                child: LoadingSpinner(),
                              )
                            : FlatButton(
                                onPressed: () => _onSave(context),
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
            onPressed: widget.toggleMode,
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
