import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/providers/orders.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem item;

  const OrderItemCard(this.item);

  @override
  _OrderItemCardState createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard>
    with SingleTickerProviderStateMixin {
  var _expanded = false;

  void onTap() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
              title: Text('\$${widget.item.amount.toStringAsFixed(2)}'),
              subtitle: Text(
                DateFormat.yMMMMd().add_jm().format(widget.item.dateTime),
              ),
              trailing: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            ),
            AnimatedContainer(
              padding: const EdgeInsets.only(
                  left: 20, top: 0, right: 20, bottom: 20),
              duration: Duration(milliseconds: 150),
              height: _expanded ? widget.item.items.length * 20.0 + 20 : 0,
              child: ListView.builder(
                itemCount: widget.item.items.length,
                itemBuilder: (ctx, idx) {
                  final item = widget.item.items[idx];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(item.product.title),
                        ),
                        Text('${item.quantity} pcs'),
                        SizedBox(width: 20),
                        Text(
                            '\$${(item.product.price * item.quantity).toStringAsFixed(2)}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
