// ignore_for_file: avoid_print

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:sqflite/sqlite_api.dart';

class SqfliteDbService {
  late sqflite.Database? database;
  late String dbPath;

  Future<void> getOrCreateDatabaseHandle() async {
    try {
      var databasesPath = await sqflite.getDatabasesPath();
      dbPath = path.join(databasesPath, 'stock_ticker.db');
      database = await sqflite.openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) async {
          await db.execute(
            'CREATE TABLE stocks (id INTEGER PRIMARY KEY, symbol TEXT, name TEXT, price REAL)',
          );
        },
      );
    } catch (e) {
      print('SQFliteDbService getOrCreateDatabaseHandle: $e');
    }
  }

  Future<void> printAllStocksInDbToConsole() async {
    try {
      final stocks = await database!.query('stocks');
      print('stocks: $stocks');
    } catch (e) {
      print('SQFliteDbService printAllStocksInDbToConsole: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllStocksFromDb() async {
    try {
      return await database!.query('stocks');
    } catch (e) {
      print('SQFliteDbService getAllStocksFromDb: $e');
      return <Map<String, dynamic>>[];
    }
  }

  Future<void> deleteDb() async {
    try {
      await sqflite.deleteDatabase(dbPath);
      database = null;
    } catch (e) {
      print('SQFliteDbService deleteDb: $e');
    }
  }

  Future<void> insertStock(Map<String, dynamic> stock) async {
    try {
      await database!.insert('stocks', stock,
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('SQFliteDbService insertStock: $e');
    }
  }

  Future<void> updateStock(Map<String, dynamic> stock) async {
    try {
      await database!.update('stocks', stock, whereArgs: [stock['id']]);
    } catch (e) {
      print('SQFliteDbService updateStock: $e');
    }
  }

  Future<void> deleteStock(Map<String, dynamic> stock) async {
    try {
      await database!
          .delete('stocks', where: 'id = ?', whereArgs: [stock['id']]);
    } catch (e) {
      print('SQFliteDbService deleteStock: $e');
    }
  }
}
