import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) _onSubmit;

  TransactionForm(this._onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final title = this._titleController.text;
    final value = double.tryParse(this._valueController.text) ?? 0.0;

    if (title.isNotEmpty && value != 0.0 && this._selectedDate != null) {
      this.widget._onSubmit(title, value, this._selectedDate);
    }
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        Duration(days: 365),
      ),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) setState(() => this._selectedDate = pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            TextField(
              controller: this._titleController,
              onSubmitted: (_) => this._submitForm(),
              decoration: InputDecoration(
                labelText: 'Título',
                prefixIcon: Icon(Icons.title),
              ),
            ),
            TextField(
              controller: this._valueController,
              onSubmitted: (_) => this._submitForm(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
                prefixIcon: Icon(Icons.attach_money),
              ),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text((this._selectedDate == null)
                        ? 'Nenhuma data selecionada.'
                        : 'Data Selecionada: ${DateFormat('dd/MM/y').format(this._selectedDate)}'),
                  ),
                  FlatButton(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: this._showDatePicker,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  child: Text('Nova Transação'),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  onPressed: _submitForm,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
