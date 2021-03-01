import 'package:flutter/material.dart';
import 'package:flutter_database_1/models/transactions.dart';
import 'package:flutter_database_1/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Information Form"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Product"),
                  autofocus: true,
                  controller: titleController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Please enter a product title.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Value"),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  validator: (String str) {
                    if (str.isEmpty) {
                      return "Please enter a price.";
                    }
                    if (double.parse(str) < 0) {
                      return "Please enter a price weather it is more than zero.";
                    }
                    return null;
                  },
                ),
                FlatButton(
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      var title = titleController.text;
                      var amount = amountController.text;
                      print(title);
                      print(amount);

                      //create obj
                      Transactions statementItem = Transactions(
                          title: title,
                          amount: double.parse(amount),
                          date: DateTime.now());

                      //call provider
                      var provider = Provider.of<TransactionProvider>(context,
                          listen: false);
                      provider.addTransaction(statementItem);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Add"),
                  color: Colors.green,
                  textColor: Colors.white,
                )
              ],
            ),
          ),
        ));
  }
}
