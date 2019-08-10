import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTransaction;

  const TransactionList(this.transactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/empty.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'No Transactions Added Yet!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) => TransactionTile(
                key: ValueKey(transactions[index].id),
                txn: transactions[index],
                deleteTransaction: _deleteTransaction,
              ),
              itemCount: transactions.length,
            ),
    );
  }
}
