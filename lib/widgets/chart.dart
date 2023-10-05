import 'package:flutter/material.dart';
import 'package:lab/models/transactions.dart';

import 'package:lab/widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  final List<transaction> recentTransaction;
  Chart(this.recentTransaction);
  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year) {
          totalSum += recentTransaction[i].amount;
        }
      }
      return {'day': weekDay.day, 'amount': totalSum};
    });
  }

  double get maxSpending {
    return groupedTransaction.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransaction.map((e) {
            return Flexible(
              fit: FlexFit
                  .tight, //The child is forced to fill the available space.
              child: ChartBar(
                  e['day'].toString()[0],
                  (e['amount'] as double),
                  maxSpending == 0
                      ? 0.0
                      : (e['amount'] as double) / maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
