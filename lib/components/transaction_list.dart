import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:projeto_despesas_semanais/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child:
          transactions.isEmpty
              ? Column(
                children: <Widget>[
                  Text(
                    "Nenhuma Transação Cadastrada!",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              )
              : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  final tr = transactions[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: FittedBox(
                            child: Text('R\$ ${tr.value.toStringAsFixed(2)}'),
                          ),
                        ),
                      ),
                      title: Text(
                        tr.title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      subtitle: Text(
                        DateFormat('d MMM y').format(tr.date),
                        style: TextStyle(color: Colors.blueGrey),
                      ),
                      trailing: IconButton(
                        onPressed: () => onRemove(tr.id),
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
