import 'package:dmit2504_assignment03/services/sqflite_db_service.dart';
import 'package:dmit2504_assignment03/services/stock_service.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final SqfliteDbService _dbService = SqfliteDbService();
  List<Map<String, dynamic>> _stocks = [];
  String _stockSymbol = '';

  void _addStock() async {
    if (_stockSymbol.isEmpty) return;

    final companyInfo = await StockService.getCompanyInfo(_stockSymbol);
    final quoteInfo = await StockService.getQuote(_stockSymbol);

    if (companyInfo == null || quoteInfo == null) return;

    try {
      await _dbService.insertStock({
        'symbol': companyInfo['Symbol'],
        'name': companyInfo['Name'],
        'price': quoteInfo['Global Quote']['05. price'],
      });
      _refreshStocks();
    } catch (e) {
      // ignore: avoid_print
      print('Error adding stock: $e');
    }
  }

  void _resetDb() async {
    await _dbService.deleteDb();
    _initDb();
  }

  void _initDb() async {
    await _dbService.getOrCreateDatabaseHandle();
    _refreshStocks();
  }

  void _refreshStocks() async {
    var dbStocks = await _dbService.getAllStocksFromDb();
    setState(() => _stocks = dbStocks);
  }

  Future _showAddStockDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Stock'),
          content: TextField(
            onChanged: (value) => _stockSymbol = value,
            decoration: const InputDecoration(hintText: 'Stock Symbol'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _addStock();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _initDb();
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
              onPressed: _resetDb,
              child: const Text('Delete All Records and Db'),
            ),
            ElevatedButton(
              onPressed: _showAddStockDialog,
              child: const Text('Add Stock'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _stocks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Symbol: ${_stocks[index]['symbol']}'),
                    subtitle: Text('Name: ${_stocks[index]['name']}'),
                    trailing: Text('${_stocks[index]['price']}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
