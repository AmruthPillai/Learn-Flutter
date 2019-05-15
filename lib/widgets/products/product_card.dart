import 'package:flutter/material.dart';
import 'package:learn_flutter/models/product.dart';
import 'package:learn_flutter/scoped_models/products.dart';
import 'package:learn_flutter/widgets/products/address_box.dart';
import 'package:learn_flutter/widgets/products/price_tag.dart';
import 'package:learn_flutter/widgets/ui_elements/product_title.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;

  ProductCard(this.product, this.index);

  Widget _buildTitlePriceRow() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: ProductTitle(
              product.title,
            ),
          ),
          Expanded(
            flex: 1,
            child: PriceTag(
              product.price.toString(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info_outline),
          color: Colors.teal,
          onPressed: () {
            Navigator.pushNamed<bool>(
              context,
              '/product/' + index.toString(),
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.favorite_border),
          color: Colors.red,
          onPressed: () {
            ProductsModel.of(context).selectProduct(index);
            ProductsModel.of(context).toggleFavorite();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.image),
          _buildTitlePriceRow(),
          SizedBox(height: 12.0),
          AddressBox('Union Square, San Francisco'),
          SizedBox(height: 6.0),
          _buildActionButtons(context),
        ],
      ),
    );
  }
}
