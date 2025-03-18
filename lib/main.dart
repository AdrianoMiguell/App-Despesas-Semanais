import 'package:flutter/material.dart';
import 'package:projeto_despesas_semanais/models/transaction.dart';
import 'package:intl/intl.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final _transactions = [
    Transaction('t1', 'Novo Tênis de Corrida', 310.55, DateTime.now()),
    Transaction('t2', 'Nova Roupa de Corrida', 50.55, DateTime.now()),
    Transaction('t3', 'Bola de Futebol', 110.00, DateTime.now()),
    Transaction('t4', 'Pátins', 78.54, DateTime.now()),
    Transaction('t5', 'Notebook', 3010.55, DateTime.now()),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Despesas Semanais')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.lightBlue,
              child: Text('Gráfico'),
              elevation: 5,
            ),
          ),
          Column(
            children:
                _transactions.map((tr) {
                  return Card(
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2),
                          ),
                          child: Text(
                            'R\$ ${tr.value.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              tr.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat('d MMM y').format(tr.date),
                              style: TextStyle(color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).toList(),
          ),
          Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Titulo'),
                  ),
                  TextField(
                    controller: valueController,
                    decoration: InputDecoration(labelText: 'Valor (R\$)'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          print(titleController.text);
                          print(valueController.text);
                        },
                        child: Text(
                          "Nova Transação",
                          style: TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
