import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  const ProductCreatePage(this.addProduct);

  @override
  _ProductCreatePageState createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _titleValue;
  String _descriptionValue;
  double _priceValue;

  _buildTitleTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Product Title'),
      onChanged: (String value) => setState(() => _titleValue = value),
    );
  }

  _buildDescriptionTextField() {
    return TextField(
      maxLines: 4,
      decoration: InputDecoration(labelText: 'Product Description'),
      keyboardType: TextInputType.multiline,
      onChanged: (String value) => setState(() => _descriptionValue = value),
    );
  }

  _buildPriceTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number,
      onChanged: (String value) =>
          setState(() => _priceValue = double.parse(value)),
    );
  }

  _submitForm() {
    final Map<String, dynamic> product = {
      'title': _titleValue,
      'description': _descriptionValue,
      'price': _priceValue,
      'image': 'assets/food.jpg',
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  _buildProductCreateButton() {
    return RaisedButton(
      child: Text('Save'),
      color: Theme.of(context).accentColor,
      textColor: Colors.white,
      onPressed: _submitForm,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[
          _buildTitleTextField(),
          _buildDescriptionTextField(),
          _buildPriceTextField(),
          SizedBox(height: 10.0),
          _buildProductCreateButton()
        ],
      ),
    );
  }
}
