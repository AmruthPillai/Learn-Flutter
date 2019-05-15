import 'package:flutter/material.dart';
import 'package:learn_flutter/models/product.dart';
import 'package:learn_flutter/pages/product_edit.dart';
import 'package:learn_flutter/scoped_models/products.dart';
import 'package:scoped_model/scoped_model.dart';

class ProductListPage extends StatelessWidget {
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

  Widget _buildProductImage(Product product) {
    return CircleAvatar(
      backgroundImage: AssetImage(product.image),
    );
  }

  Widget _buildEditButton(
      BuildContext context, int index, ProductsModel model) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        model.selectProduct(index);

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductEditPage();
            },
          ),
        );
      },
    );
  }

  ListTile _buildProductListTile(
      BuildContext context, int index, ProductsModel model) {
    final Product product = model.products[index];
    return ListTile(
      leading: _buildProductImage(product),
      title: Text(product.title),
      subtitle: Text('\$' + product.price.toString()),
      trailing: _buildEditButton(context, index, model),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            model.selectProduct(index);
            return Dismissible(
              direction: DismissDirection.endToStart,
              key: Key(index.toString()),
              background: _buildDismissDeleteBackground(),
              onDismissed: (DismissDirection direction) =>
                  model.deleteProduct(),
              child: Column(
                children: <Widget>[
                  _buildProductListTile(context, index, model),
                  Divider(),
                ],
              ),
            );
          },
          itemCount: model.products.length,
        );
      },
    );
  }
}
