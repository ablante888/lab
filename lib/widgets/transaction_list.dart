//import 'dart:html';

import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:lab/widgets/new_transaction.dart';
import '../models/transactions.dart';

import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  //const TransactionList({Key? key}) : super(key: key);
  List<transaction> NewTransaction;
  Function deleteTransaction;
  TransactionList(this.NewTransaction, this.deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return NewTransaction.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                Text(
                  'No transaction yet',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            );
          })
        : //ListView.builder(
        // itemBuilder: ((context, index) {
        // return TransactionItem(
        //  NewTransaction: NewTransaction[index],
        // deleteTransaction: deleteTransaction,
        // );
        ListView(
            children: [
              ...NewTransaction.map((tx) {
                return TransactionItem(
                    key: ValueKey(tx.id),
                    NewTransaction: tx,
                    deleteTransaction: deleteTransaction);
              })
            ],
          );
    // Card(
    //   child: Row(
    //     children: [
    //       Container(
    //         margin:
    //             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    //         decoration: BoxDecoration(
    //             border: Border.all(
    //           color: Theme.of(context).primaryColor,
    //           width: 2,
    //         )),
    //         padding: EdgeInsets.all(10),
    //         child: Text(
    //           '\$${NewTransaction[index].amount.toStringAsFixed(3)}',
    //           style: TextStyle(
    //               color: Theme.of(context).primaryColor,
    //               fontSize: 20.0,
    //               fontWeight: FontWeight.bold),
    //         ),
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             NewTransaction[index].title,
    //             style: TextStyle(
    //                 fontSize: 15, fontWeight: FontWeight.bold),
    //           ),
    //           Text(
    //             NewTransaction[index].date.toString(),
    //             style: TextStyle(color: Colors.blueGrey),
    //           )
    //         ],
    //       )
    //     ],
    //   ),
    // );
    //  }),
    //  itemCount: NewTransaction.length,
    // children: NewTransaction.map((tx) {
    //   why not    =>
    // })
    //  .toList(), //what is the use of tolist()
  }
}
