import 'package:app/data/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class PlanDAO {
  final AppDatabase dbProvider;

  PlanDAO([AppDatabase? dbProvider])
      : dbProvider = dbProvider ?? AppDatabase.dbProvider;
}
