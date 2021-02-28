import 'package:flutter/foundation.dart';
import 'package:flutter_database_1/models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> transactions = [];

  List<Transaction> getTransaction() {
    return transactions;
  }

  void addTransaction(Transaction statement) {
    transactions.insert(0, statement);

    //notify consumer
    notifyListeners();
  }
}
