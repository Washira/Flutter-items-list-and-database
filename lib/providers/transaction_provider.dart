import 'package:flutter/foundation.dart';
import 'package:flutter_database_1/database/transaction_db.dart';
import 'package:flutter_database_1/models/transactions.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];

  List<Transactions> getTransaction() {
    return transactions;
  }

  void addTransaction(Transactions statement) async{
    var db = await TransactionDB(dbName: "transactions.db").openDatabase();
    print(db);
    transactions.insert(0, statement);

    //notify consumer
    notifyListeners();
  }
}
