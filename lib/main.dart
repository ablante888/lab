//import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab/widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/user_transaction.dart';
import '../models/transactions.dart';

void main() {
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'personal expense',
      theme: ThemeData(
        primaryColor: Colors.pink,
        accentColor: Colors.grey,
        textTheme: ThemeData.light()
            .textTheme
            .copyWith(button: TextStyle(color: Colors.white)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<transaction> userTransaction = [
    transaction(id: 't1', title: 'shoe', amount: 70.0, date: DateTime.now()),
    transaction(id: 't2', title: 'shirt', amount: 30.0, date: DateTime.now())
  ];
  bool showChart = false;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didCahangeAppLifeCycleState() {
    print('state');
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  List<transaction> get recentTransaction {
    return userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void addNewTransaction(String title, double amount, DateTime pickedDate) {
    final newTx = transaction(
        title: title,
        amount: amount,
        date: pickedDate,
        id: DateTime.now().toString());
    setState(() {
      userTransaction.add(newTx);
    });
  }

  void addTransaction(BuildContext cxt) {
    showModalBottomSheet(
      context: cxt,
      builder: (_) {
        return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(addNewTransaction));
      },
    );
  }

  void deleteTransaction(String id) {
    setState(() {
      userTransaction.removeWhere((element) => element.id == id);
    });
  }

  List<Widget> buildSwitch(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Row(
        children: [
          const Text(
            'show chart',
            // style: Theme.of(context).textTheme.titleMedium,
          ),
          Switch.adaptive(
              activeColor: Colors.amber,
              value: showChart,
              onChanged: (val) {
                setState(() {
                  showChart = val;
                });
              }),
        ],
      ),
      showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.5,
              child: Chart(recentTransaction))
          : txListWidget
    ];
  }

  List<Widget> buidPortrait(
      MediaQueryData mediaQuery, AppBar appBar, Widget txListWidget) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(recentTransaction),
      ),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLanskape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text('flutter'),
      actions: <Widget>[
        IconButton(
          onPressed: () => addTransaction(context),
          icon: Icon(Icons.add),
          color: Colors.amber,
        )
      ],
    );
    final txList = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.6,
        child: TransactionList(userTransaction, deleteTransaction));

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLanskape) ...buildSwitch(mediaQuery, appBar, txList),
              if (!isLanskape) ...buidPortrait(mediaQuery, appBar, txList),
              // if (isLanskape) ...buildSwitch(mediaQuery, appBar, txList),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => addTransaction(context),
            ),
    );
  }
}
