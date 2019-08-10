import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/cart_item_card.dart';

class CartPage extends StatelessWidget {
  static const String routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    var cartStore = Provider.of<Cart>(context);
    var cartItems = cartStore.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (ctx, idx) => CartItemCard(
                  cartItems[idx],
                  cartStore.addItem,
                  cartStore.removeItem,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'CART TOTAL',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '\$${cartStore.totalCartValue.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                Provider.of<Orders>(context, listen: false)
                    .addOrder(cartItems, cartStore.totalCartValue);
                cartStore.clearCart();
              },
              child: Text(
                'ORDER NOW',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
