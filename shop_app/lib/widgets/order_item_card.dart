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

class _OrderItemCardState extends State<OrderItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('\$${widget.item.amount.toStringAsFixed(2)}'),
              subtitle: Text(
                DateFormat.yMMMMd().add_jm().format(widget.item.dateTime),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              ),
            ),
            _expanded
                ? Container(
                    padding: const EdgeInsets.all(20),
                    height: min(widget.item.items.length * 20.0 + 100, 150),
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
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
