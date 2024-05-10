// ignore_for_file: constant_identifier_names

import 'package:app/data/database/table/weight_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart'
    show MissingPlatformDirectoryException, getApplicationDocumentsDirectory;

class AppDatabase {
  static final AppDatabase dbProvider = AppDatabase();

  static const DATABASE_NAME = 'app.db';
  static const DATABASE_VERSION = 1;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    try {
      _database = await _initDB();
      return _database!;
    } on MissingPlatformDirectoryException {
      throw const UnableToGetDocumentsDirectory();
    }
  }

  Future<String> get _databasePath async {
    final docsPath = await getApplicationDocumentsDirectory();
    return join(docsPath.path, DATABASE_NAME);
  }

  Future<Database> _initDB() async {
    final dbPath = await _databasePath;
    Database database = await openDatabase(
      dbPath,
      version: DATABASE_VERSION,
      onCreate: _createDB,
      singleInstance: true,
    );
    return database;
  }

  Future<void> _createDB(Database database, int version) async {
    WeightTable.createTable(database, version);
  }
}

class DatabaseAlreadyOpenException implements Exception {
  const DatabaseAlreadyOpenException([this.message]);

  final String? message;
  @override
  String toString() => message ?? 'Database already open';
}

class UnableToGetDocumentsDirectory implements Exception {
  const UnableToGetDocumentsDirectory([this.message]);

  final String? message;
  @override
  String toString() => message ?? 'Unable to get documents directory';
}
