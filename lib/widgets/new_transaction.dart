//import 'dart:js';

import 'package:flutter/material.dart';
import './user_transaction.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction) {
    print('NewTransaction widget constructor');
  }

  @override
  State<NewTransaction> createState() {
    print('createstate called');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  _NewTransactionState() {
    print('state constructore called');
  }
  @override
  void initState() {
    print('initstate called');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    print('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  final titleInput = TextEditingController();

  final amountInput = TextEditingController();

  DateTime? selectedDate;

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  label: Text('Title'),
                ),
                controller: titleInput,
              ),
              TextField(
                decoration: InputDecoration(label: Text('Amount')),
                controller: amountInput,
                keyboardType: TextInputType.number,
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(selectedDate == null
                          ? 'Date is not chosen'
                          : 'Date chosen:${selectedDate.toString()}'),
                    ),
                    FlatButton(
                      onPressed: presentDatePicker,
                      child: Text(
                        'Choose date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: (() {
                  widget.addNewTransaction(titleInput.text,
                      double.parse(amountInput.text), selectedDate);
                }),
                child: Text('Add transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button?.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
