import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatefulWidget {
  final Transaction txn;
  final Function deleteTransaction;

  const TransactionTile({Key key, this.txn, this.deleteTransaction})
      : super(key: key);

  @override
  _TransactionTileState createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      key: widget.key,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(14),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '\$${widget.txn.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.txn.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                DateFormat().format(widget.txn.timestamp),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              )
            ],
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.delete),
            iconSize: 18,
            color: Colors.black54,
            onPressed: () {
              widget.deleteTransaction(widget.txn.id);
            },
          ),
        ],
      ),
    );
  }
}
