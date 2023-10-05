import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transactions.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.NewTransaction,
    required this.deleteTransaction,
  }) : super(key: key);

  final transaction NewTransaction;
  final Function deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? bgColor;
  @override
  void initState() {
    const availableColors = [
      Colors.green,
      Colors.amber,
      Colors.blue,
      Colors.brown
    ];
    bgColor = availableColors[Random().nextInt(3)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child:
                  Text('\$${widget.NewTransaction.amount.toStringAsFixed(3)}'),
            ),
          ),
        ),
        title: Text(widget.NewTransaction.title),
        subtitle: Text(widget.NewTransaction.date.toString()),
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton.icon(
                onPressed: () {
                  final snackBar = SnackBar(
                    content: Text('Are you shour to delete !'),
                    action: SnackBarAction(label: 'Undo', onPressed: () {}),
                  );
                  widget.deleteTransaction(widget.NewTransaction.id);
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                icon: Icon(Icons.delete),
                textColor: Colors.red,
                label: Text('delete'))
            : IconButton(
                onPressed: () =>
                    widget.deleteTransaction(widget.NewTransaction.id),
                icon: Icon(Icons.delete),
                color: Colors.red,
              ),
      ),
    );
  }
}
