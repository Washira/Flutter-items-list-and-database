import 'package:flutter/foundation.dart';
import 'package:flutter_database_1/database/transaction_db.dart';
import 'package:flutter_database_1/models/transactions.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];

  List<Transactions> getTransaction() {
    return transactions;
  }

  void initdata() async{
    var db = TransactionDB(dbName: "transactions.db");

    // load data to display
    transactions = await db.loadAllData();

    // notify consumer
    notifyListeners();
  }

  void addTransaction(Transactions statement) async {
    var db = TransactionDB(dbName: "transactions.db");

    // save data
    await db.insertData(statement);

    // load data to display
    transactions = await db.loadAllData();

    // notify consumer
    notifyListeners();
  }
}
