import 'package:sqflite/sqflite.dart';

class PlanTables {
  static const String plansNameTable = 'plans';
  static const String workoutDaysTable = 'workout_days';
  static const String daysTable = 'days';
  static const String exercisesTable = 'exercises';
  static const String progressTable = 'progress';

  static const Map<String, String> createQuery = {
    plansNameTable: '''
      CREATE TABLE IF NOT EXISTS $plansNameTable (
        "plan_id" INTEGER PRIMARY KEY AUTOINCREMENT,
        "plan_name" TEXT NOT NULL,
        "created_at" INTEGER NOT NULL DEFAULT (cast(strftime('%s','now') as int)),
        "updated_at" INTEGER
      );''',
    workoutDaysTable: '''
      CREATE TABLE IF NOT EXISTS $workoutDaysTable (
        "workout_day_id" INTEGER PRIMARY KEY,
        "plan_id" INTEGER NOT NULL,
        "day_id" INTEGER NOT NULL,
        FOREIGN KEY (plan_id) REFERENCES $plansNameTable(plan_id) ON DELETE CASCADE,
        FOREIGN KEY (day_id) REFERENCES $daysTable(day_id)
    );''',
    daysTable: '''
      CREATE TABLE IF NOT EXISTS $daysTable (
        day_id INTEGER PRIMARY KEY AUTOINCREMENT,
        day_name text UNIQUE NOT NULL
    );''',
    exercisesTable: '''
      CREATE TABLE IF NOT EXISTS $exercisesTable (
        exercise_id INTEGER PRIMARY KEY AUTOINCREMENT,
        workout_day_id INTEGER NOT NULL,
        exercise_name TEXT NOT NULL,
        min_reps INT,
        max_reps INT,
        sets INT,
        FOREIGN KEY (workout_day_id) REFERENCES $workoutDaysTable(workout_day_id) ON DELETE CASCADE
    );''',
    progressTable: '''
      CREATE TABLE IF NOT EXISTS $progressTable (
        progress_id INTEGER PRIMARY KEY AUTOINCREMENT,
        exercise_id INTEGER not NULL,
        weight TEXT,
        repetitions TEXT,
        sets INT,
        FOREIGN key (exercise_id) REFERENCES $exercisesTable(exercise_id) ON DELETE CASCADE
    );''',
  };

  static void createTable(Database database, int version) async {
    await database.execute(createQuery[plansNameTable]!);
    await database.execute(createQuery[workoutDaysTable]!);
    await database.execute(createQuery[daysTable]!);
    await database.execute(createQuery[exercisesTable]!);
    await database.execute(createQuery[progressTable]!);
  }
}
