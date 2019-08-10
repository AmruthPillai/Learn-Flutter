import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;

  const BigText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 40,
      ),
    );
  }
}
