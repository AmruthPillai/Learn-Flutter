import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final Function increaseQty;
  final Function decreaseQty;

  const CartItemCard(this.item, this.increaseQty, this.decreaseQty);

  double get itemTotal => item.product.price * item.quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Dismissible(
        key: ValueKey(item.id),
        direction: DismissDirection.horizontal,
        movementDuration: Duration(milliseconds: 100),
        confirmDismiss: (direction) async {
          var result = false;

          if (direction == DismissDirection.startToEnd) {
            increaseQty(item.product);
          } else if (direction == DismissDirection.endToStart) {
            if (item.quantity == 1) {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text('Are you sure?'),
                  content:
                      Text('Do you want to remove the item from the cart?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () {
                        decreaseQty(item.product);
                        Navigator.of(context).pop(true);
                      },
                      child: Text('Yes'),
                    ),
                  ],
                ),
              );
            }
            decreaseQty(item.product);
          }

          return result;
        },
        background: _buildIncreaseDismissBackground(),
        secondaryBackground: _buildDecreaseDismissBackground(),
        child: Card(
          child: Row(
            children: <Widget>[
              Image.network(
                item.product.imageUrl,
                width: 90,
                height: 100,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.product.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '\$${item.product.price} x ${item.quantity} pcs',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  )
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  '\$${itemTotal.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDecreaseDismissBackground() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.remove,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: 5),
          Text(
            'REMOVE',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(20),
    );
  }

  Widget _buildIncreaseDismissBackground() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.add,
            color: Colors.white,
            size: 32,
          ),
          SizedBox(width: 5),
          Text(
            'ADD',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.9),
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.all(20),
    );
  }
}
