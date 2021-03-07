import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_database_1/models/transactions.dart';
import 'package:flutter_database_1/providers/transaction_provider.dart';
import 'package:flutter_database_1/screens/form_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Accounting"),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FormScreen();
                  }));
                }),

          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget child) {
            var count = provider.transactions.length;
            if (count <= 0) {
              return Center(
                child: Text(
                  "No data",
                  style: TextStyle(fontSize: 40),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, int index) {
                    Transactions data = provider.transactions[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      elevation: 5,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: FittedBox(
                            child: Text(data.amount.toString()),
                          ),
                        ),
                        title: Text(data.title),
                        subtitle:
                            Text(DateFormat("dd/MM/yyyy").format(data.date)),
                      ),
                    );
                  });
            }
          },
        ));
  }
}
