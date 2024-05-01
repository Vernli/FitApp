import 'package:sqflite/sqflite.dart';

class WeightTable {
  static const String WEIGHT_TABLE_NAME = "weight";

  static void createTable(Database database, int version) async {
    await database.execute('''
      CREATE TABLE weight (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        weight REAL NOT NULL,
        date TEXT NOT NULL
      )''');
  }
}
