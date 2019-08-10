import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/add_transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  final List<Transaction> _transactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 32.99,
    //   timestamp: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Groceries',
    //   amount: 15.99,
    //   timestamp: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((txn) =>
            txn.timestamp.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void _addNewTransaction(String title, double amount, DateTime dateTime) {
    final newTransaction = Transaction(
      id: dateTime.toString(),
      title: title,
      amount: amount,
      timestamp: dateTime,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((txn) => txn.id == id);
    });
  }

  void openModalSheet(ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => AddTransaction(_addNewTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => openModalSheet(context),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => openModalSheet(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Column(
              children: <Widget>[
                Chart(_recentTransactions),
                TransactionList(_transactions, _deleteTransaction),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
