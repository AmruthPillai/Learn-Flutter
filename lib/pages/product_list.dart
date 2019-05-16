import 'package:flutter/material.dart';
import 'package:learn_flutter/models/product.dart';
import 'package:learn_flutter/pages/product_edit.dart';
import 'package:learn_flutter/scoped_models/products.dart';

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

  Widget _buildEditButton(BuildContext context, int index) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        ProductsModel.of(context).selectProduct(index);

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

  ListTile _buildProductListTile(BuildContext context, int index) {
    final Product product = ProductsModel.of(context).products[index];
    return ListTile(
      leading: _buildProductImage(product),
      title: Text(product.title),
      subtitle: Text('\$' + product.price.toString()),
      trailing: _buildEditButton(context, index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        ProductsModel.of(context).selectProduct(index);
        return Dismissible(
          direction: DismissDirection.endToStart,
          key: Key(index.toString()),
          background: _buildDismissDeleteBackground(),
          onDismissed: (DismissDirection direction) =>
              ProductsModel.of(context).deleteProduct(),
          child: Column(
            children: <Widget>[
              _buildProductListTile(context, index),
              Divider(),
            ],
          ),
        );
      },
      itemCount: ProductsModel.of(context).allProducts.length,
    );
  }
}
