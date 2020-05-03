import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final void Function(String) _onDelete;

  TransactionList(this._transactions, this._onDelete);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      child: this._transactions.isEmpty
          ? Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    'Nenhuma transação realizada. Sad! :(',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                Container(
                    padding: EdgeInsetsDirectional.only(top: 10),
                    child: Image.network(
                      'https://i.imgflip.com/1v7qv9.jpg',
                      height: 250,
                    ))
              ],
            )
          : ListView.builder(
              itemCount: this._transactions.length,
              itemBuilder: (ctx, index) {
                var tr = this._transactions[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: ListTile(
                    title: Text(
                      tr.title,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat('d MMM y').format(tr.date),
                    ),
                    leading: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(3)),
                        boxShadow: <BoxShadow>[
                          new BoxShadow(
                            color: Colors.black26,
                            blurRadius: 2.0,
                            offset: new Offset(1.5, 1.5),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'R\$ ' + tr.value.toStringAsFixed(2),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => this._onDelete(tr.id),
                    ),
                  ),
                );
              }),
    );
  }
}
