import 'package:flutter/material.dart';
import 'package:learn_flutter/models/product.dart';

class ProductEditPage extends StatefulWidget {
  final int index;
  final Product product;
  final Function addProduct;
  final Function updateProduct;

  const ProductEditPage(
      {this.index, this.product, this.addProduct, this.updateProduct});

  @override
  _ProductEditPageState createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/food.jpg',
  };

  Widget _buildTitleTextField() {
    return TextFormField(
      initialValue: (widget.product == null) ? '' : widget.product.title,
      decoration: InputDecoration(labelText: 'Product Title'),
      keyboardType: TextInputType.text,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Title is required!';
        } else if (value.length < 5) {
          return 'Title must be at least 5 characters long.';
        }
      },
      textInputAction: TextInputAction.next,
      onSaved: (String value) => _formData['title'] = value,
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      maxLines: 4,
      initialValue: (widget.product == null) ? '' : widget.product.description,
      decoration: InputDecoration(labelText: 'Product Description'),
      keyboardType: TextInputType.multiline,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Description is required!';
        } else if (value.length < 10) {
          return 'Description must be at least 10 characters long.';
        }
      },
      textInputAction: TextInputAction.next,
      onSaved: (String value) => _formData['description'] = value,
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      initialValue:
          (widget.product == null) ? '' : widget.product.price.toString(),
      decoration: InputDecoration(labelText: 'Product Price'),
      keyboardType: TextInputType.number,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Price is required!';
        } else if (!RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price must be a valid number.';
        }
      },
      textInputAction: TextInputAction.done,
      onSaved: (String value) => _formData['price'] = double.parse(value),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    if (widget.product == null) {
      widget.addProduct(
        Product(
          title: _formData['title'],
          description: _formData['description'],
          price: _formData['price'],
          image: _formData['image'],
        ),
      );
    } else {
      widget.updateProduct(
        widget.index,
        Product(
          title: _formData['title'],
          description: _formData['description'],
          price: _formData['price'],
          image: _formData['image'],
        ),
      );
    }
    Navigator.pushReplacementNamed(context, '/products');
  }

  Widget _buildProductCreateButton() {
    return RaisedButton(
      child: Text('Save'),
      onPressed: _submitForm,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth =
        (deviceWidth > 550.0) ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    final Widget pageContent = Container(
      margin: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: targetPadding / 2,
            ),
            children: <Widget>[
              _buildTitleTextField(),
              _buildDescriptionTextField(),
              _buildPriceTextField(),
              SizedBox(height: 10.0),
              _buildProductCreateButton()
            ],
          ),
        ),
      ),
    );

    return (widget.product == null)
        ? pageContent
        : Scaffold(
            appBar: AppBar(
              title: Text('Edit Product'),
            ),
            body: pageContent,
          );
  }
}
