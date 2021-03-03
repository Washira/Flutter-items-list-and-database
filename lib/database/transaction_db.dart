import 'dart:io';
import 'package:flutter_database_1/models/transactions.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class TransactionDB {
  String dbName;

  //build db if it does not exist and open if it exists.
  TransactionDB({this.dbName});

  Future<Database> openDatabase() async {
    //find user location
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);

    //build db
    DatabaseFactory dbFactory = await databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  // save data
  Future<int> insertData(Transactions statement) async {
    // db => store
    // transaction.db => table "expense"
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");

    // json
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String(),
    });
    db.close();
    return keyID;
  }

  // fetch data
  Future<List> loadAllData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db);
    List transactionList = List<Transactions>();
    for (var record in snapshot) {
      transactionList.add(Transactions(
        title: record["title"],
        amount: record["amount"],
        date: DateTime.parse(record["date"]),
      ));
    }
    print(snapshot);
    return transactionList;
  }
}
