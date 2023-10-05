import 'package:flutter/material.dart';
import 'package:lab/widgets/new_transaction.dart';
import 'package:lab/widgets/transaction_list.dart';
import '../models/transactions.dart';

class UserTransaction extends StatefulWidget {
  // const UserTransaction({Key? key}) : super(key: key);

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // NewTransaction(addNewTransaction),
        // TransactionList(userTransaction)
      ],
    );
  }
}
