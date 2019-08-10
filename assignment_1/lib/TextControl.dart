import 'package:flutter/material.dart';
import 'package:assignment_1/BigText.dart';

class TextControl extends StatefulWidget {
  @override
  _TextControlState createState() => _TextControlState();
}

class _TextControlState extends State<TextControl> {
  String text = 'Hello there!';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          BigText(text),
          RaisedButton(
            color: Colors.blue,
            child: Text(
              'Change Text',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              setState(() {
                text = 'I\'ve changed!';
              });
            },
          )
        ],
      ),
    );
  }
}
