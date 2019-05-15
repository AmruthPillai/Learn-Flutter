import 'package:flutter/material.dart';
import 'package:learn_flutter/pages/product_edit.dart';

class ProductListPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;
  final Function updateProduct;
  final Function deleteProduct;

  ProductListPage(this.products, this.updateProduct, this.deleteProduct);

  Widget _buildDismissDeleteBackground() {
    return Container(
      color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(Icons.delete, color: Colors.white),
          SizedBox(width: 10.0),
          Text(
            'DELETE',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 20.0)
        ],
      ),
    );
  }

  Widget _buildProductImage(int index) {
    return CircleAvatar(
      backgroundImage: AssetImage(products[index]['image']),
    );
  }

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => _editProduct(context, index),
    );
  }

  ListTile _buildProductListTile(BuildContext context, int index) {
    return ListTile(
      leading: _buildProductImage(index),
      title: Text(products[index]['title']),
      subtitle: Text('\$' + products[index]['price'].toString()),
      trailing: _buildEditButton(context, index),
    );
  }

  void _editProduct(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return ProductEditPage(
            index: index,
            product: products[index],
            updateProduct: updateProduct,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          direction: DismissDirection.endToStart,
          key: Key(index.toString()),
          background: _buildDismissDeleteBackground(),
          onDismissed: (DismissDirection direction) => deleteProduct(index),
          child: Column(
            children: <Widget>[
              _buildProductListTile(context, index),
              Divider(),
            ],
          ),
        );
      },
      itemCount: products.length,
    );
  }
}
