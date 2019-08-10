import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final date = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;

      recentTransactions.forEach((txn) {
        if (txn.timestamp.day == date.day &&
            txn.timestamp.month == date.month &&
            txn.timestamp.year == date.year) {
          totalAmount += txn.amount;
        }
      });

      return {
        'day': DateFormat.E().format(date).substring(0, 2),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get totalAmount {
    return groupedTransactionValues.fold(0, (sum, txn) {
      return sum += txn['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupedTransactionValues.map((txn) {
            return Expanded(
              child: ChartBar(
                label: txn['day'],
                spentAmount: txn['amount'],
                spentTotal: totalAmount == 0.0
                    ? 0.0
                    : (txn['amount'] as double) / totalAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
