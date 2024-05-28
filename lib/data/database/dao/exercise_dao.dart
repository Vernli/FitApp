import 'package:app/data/database/app_database.dart';

class ExerciseDAO {
  final AppDatabase dbProvider;

  ExerciseDAO([AppDatabase? dbProvider])
      : dbProvider = dbProvider ?? AppDatabase.dbProvider;
}
