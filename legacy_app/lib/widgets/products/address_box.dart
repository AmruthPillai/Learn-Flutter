import 'package:flutter/material.dart';

class AddressBox extends StatelessWidget {
  final String address;

  AddressBox(this.address);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 6.0,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Text('Union Square, San Francisco'),
    );
  }
}
