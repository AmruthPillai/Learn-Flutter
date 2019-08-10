import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final Transaction txn;
  final Function _deleteTransaction;

  const TransactionTile(this.txn, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
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
              '\$${txn.amount.toStringAsFixed(2)}',
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
                txn.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                DateFormat().format(txn.timestamp),
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
              _deleteTransaction(txn.id);
            },
          ),
        ],
      ),
    );
  }
}
