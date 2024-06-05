import 'package:sqflite/sqflite.dart';

class PlanTables {
  static const String plansNameTable = 'plans';
  static const String workoutDaysTable = 'workout_days';
  static const String daysTable = 'days';
  static const String exercisesTable = 'exercises';
  static const String sessionsTable = 'training_sessions';
  static const String repetitionsTabe = 'repetitions';

  static const Map<String, String> createQuery = {
    plansNameTable: '''
      CREATE TABLE IF NOT EXISTS $plansNameTable (
        plan_id INTEGER PRIMARY KEY AUTOINCREMENT,
        plan_name TEXT NOT NULL,
        created_date TEXT NOT NULL,
        created_time TEXT NOT NULL,
        updated_date TEXT,
        updated_time TEXT
      );''',
    daysTable: '''
      CREATE TABLE IF NOT EXISTS $daysTable (
        day_id INTEGER PRIMARY KEY AUTOINCREMENT,
        day_name text UNIQUE NOT NULL
    );''',
    exercisesTable: '''
      CREATE TABLE IF NOT EXISTS $exercisesTable (
        exercise_id INTEGER PRIMARY KEY AUTOINCREMENT,
        plan_id INTEGER NOT NULL,
        day_id INTEGER NOT NULL,
        exercise_name TEXT NOT NULL,
        min_reps INT,
        max_reps INT,
        sets INT,
        FOREIGN KEY (plan_id) REFERENCES $plansNameTable(plan_id),
        FOREIGN KEY (day_id) REFERENCES $daysTable(day_id)
    );''',
    sessionsTable: '''
      CREATE TABLE IF NOT EXISTS $sessionsTable (
        session_id INTEGER PRIMARY KEY AUTOINCREMENT,
        exercise_id INTEGER NOT NULL,
        FOREIGN KEY (exercise_id) REFERENCES $exercisesTable(exercise_id)
    );''',
    repetitionsTabe: '''
      CREATE TABLE IF NOT EXISTS $repetitionsTabe (
        repetition_id INTEGER PRIMARY KEY AUTOINCREMENT,
        session_id INTEGER NOT NULL,
        reps INT NOT NULL,
        weight REAL NOT NULL,
        FOREIGN KEY (session_id) REFERENCES $sessionsTable(session_id)
    );''',
  };

  static const insertWeekDaysQuery = '''
    INSERT INTO $daysTable (day_name) VALUES
    ('Poniedziałek'),
    ('Wtorek'),
    ('Środa'),
    ('Czwartek'),
    ('Piątek'),
    ('Sobota'),
    ('Niedziela');
    ''';

  static void createTable(Database database, int version) async {
    await database.execute(createQuery[plansNameTable]!);
    await database.execute(createQuery[daysTable]!);
    await database.execute(createQuery[exercisesTable]!);
    await database.execute(createQuery[sessionsTable]!);
    await database.execute(createQuery[repetitionsTabe]!);
    await database.execute(insertWeekDaysQuery);
  }
}
