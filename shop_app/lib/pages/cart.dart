import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/orders.dart';
import 'package:shop_app/widgets/cart_item_card.dart';
import 'package:shop_app/widgets/loading_spinner.dart';

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
            OrderButton(cartStore: cartStore, cartItems: cartItems),
          ],
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cartStore,
    @required this.cartItems,
  }) : super(key: key);

  final Cart cartStore;
  final List<CartItem> cartItems;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: Theme.of(context).primaryColor,
      onPressed: widget.cartStore.itemCount <= 0
          ? null
          : () async {
              setState(() => _isLoading = true);
              await Provider.of<Orders>(context, listen: false)
                  .addOrder(widget.cartItems, widget.cartStore.totalCartValue);
              setState(() => _isLoading = false);
              widget.cartStore.clearCart();
            },
      child: _isLoading
          ? LoadingSpinner()
          : Text(
              'ORDER NOW',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }
}
