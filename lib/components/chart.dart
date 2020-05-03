import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;

  Chart(this._recentTransactions);

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = this._recentTransactions.fold(
        0.0,
        (value, transaction) {
          bool sameDay = transaction.date.day == weekDay.day;
          bool sameMonth = transaction.date.month == weekDay.month;
          bool sameYear = transaction.date.year == weekDay.year;

          if (sameDay && sameMonth && sameYear) {
            return value + transaction.value;
          }
          return value;
        },
      );

      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return this._groupedTransactions.fold(
          0.0,
          (sum, tr) => sum + tr['value'],
        );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: this._groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'],
                value: tr['value'],
                percentage: (this._weekTotalValue != 0.0)
                    ? ((tr['value'] as double) / this._weekTotalValue)
                    : 0.0,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
