import 'dart:math';

import 'package:flutter/material.dart';
import 'package:projeto_despesas_semanais/components/chart.dart';
import 'package:projeto_despesas_semanais/components/transaction_form.dart';
import 'package:projeto_despesas_semanais/components/transaction_list.dart';
import 'package:projeto_despesas_semanais/models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        useMaterial3: false,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
          titleSmall: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          titleLarge: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        fontFamily: 'Quicksand',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      't1',
      'Novo Sapato',
      310.55,
      DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction('t2', 'Novo Carro de Brinquedo', 100.55, DateTime.now()),
    Transaction(
      't3',
      'Novo Palito',
      510.55,
      DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction('t4', 'Novo Lapis', 1.55, DateTime.now()),
    Transaction(
      't5',
      'Novo Borrada',
      1.55,
      DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      't6',
      'Novo Livro',
      50.55,
      DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      't7',
      'Novo Celular',
      1000.55,
      DateTime.now().subtract(Duration(days: 4)),
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String nTitle, double nValue, DateTime date) {
    final newTransaction = Transaction(
      Random().nextDouble().toString(),
      nTitle,
      nValue,
      date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFromModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Semanais'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _openTransactionFromModal(context),
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_transactions, _removeTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFromModal(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
