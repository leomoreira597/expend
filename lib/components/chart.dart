import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentesTransaction;

  Chart(this.recentesTransaction, {super.key});

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      for (var i = 0; i < recentesTransaction.length; i++) {
        bool sameDay = recentesTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentesTransaction[i].date.month == weekDay.month;
        bool sameYear = recentesTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentesTransaction[i].value;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay)[0],
        'value': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(10),
      child: Row(
        children: groupedTransaction.map((tr) {
          return ChartBar(
            label: tr['day'] as String,
            value: tr['value'] as double,
            percentage: 0.5,
          );
        }).toList(),
      ),
    );
  }
}
