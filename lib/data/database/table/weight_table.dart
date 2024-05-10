import 'package:sqflite/sqflite.dart';

class WeightTable {
  static const String weightTableName = 'weight';

  static void createTable(Database database, int version) async {
    await database.execute('''
      CREATE TABLE $weightTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        weight REAL NOT NULL,
        date TEXT NOT NULL,
        time TEXT NOT NULL
      )''');
  }
}
