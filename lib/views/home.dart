import 'package:dmit2504_assignment03/services/sqflite_db_service.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final SqfliteDbService _dbService = SqfliteDbService();

  void addStock() async {}

  void clearDb() {}

  void initDb() async {
    await _dbService.getOrCreateDatabaseHandle();
    await _dbService.printAllStocksInDbToConsole();
  }

  @override
  void initState() {
    super.initState();
    initDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Ticker'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: clearDb,
              child: const Text('Delete All Records and Db'),
            ),
            ElevatedButton(
              onPressed: addStock,
              child: const Text('Add Stock'),
            ),
            const Expanded(child: Text('Hi')),
          ],
        ),
      ),
    );
  }
}
