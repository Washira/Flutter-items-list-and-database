import 'package:flutter/material.dart';
import 'package:flutter_database_1/providers/transaction_provider.dart';
import 'package:flutter_database_1/screens/form_screen.dart';
import 'package:flutter_database_1/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Account Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Accounting App'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: TabBarView(
            children: [HomeScreen(), FormScreen()],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.list),
                text: "รายการธุรกรรม",
              ),
              Tab(
                icon: Icon(Icons.add),
                text: "เพิ่มข้อมูล",
              )
            ],
          ),
        ));
  }
}
