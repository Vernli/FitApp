import 'package:app/data/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class ExerciseDAO {
  final AppDatabase dbProvider;

  ExerciseDAO([AppDatabase? dbProvider])
      : dbProvider = dbProvider ?? AppDatabase.dbProvider;

  // Getters
  Future<int> _getExerciseID(String exerciseName, int day) async {
    final database = await dbProvider.database;
    final List<Map<String, dynamic>> exercises = await database.query(
      'exercises',
      where: 'exercise_name = ? AND day_id = ?',
      whereArgs: [exerciseName, day],
    );
    return exercises[0]['exercise_id'];
  }

  Future<int> _getTrainingSessionID(int exerciseID) async {
    final Database database = await dbProvider.database;
    final List<Map<String, dynamic>> sessionID = await database.query(
      'training_sessions',
      where: 'exercise_id = ?',
      whereArgs: [exerciseID],
    );
    return sessionID.last['session_id'];
  }

  Future<List<Map<String, dynamic>>> getExerciseRepetitions(
    String exerciseName,
    int day,
  ) async {
    final Database database = await dbProvider.database;
    final int exerciseID = await _getExerciseID(exerciseName, day);
    final int sessionID = await _getTrainingSessionID(exerciseID);

    final List<Map<String, dynamic>> repetitions = await database.query(
      'repetitions',
      where: 'session_id = ?',
      whereArgs: [sessionID],
    );

    return repetitions;
  }

  Future<dynamic> getAllTrainingSessions(String exerciseName) async {
    final Database database = await dbProvider.database;
    final List<Map<String, dynamic>> sessions = await database.rawQuery(
      'SELECT * FROM repetitions JOIN training_sessions ON repetitions.session_id = training_sessions.session_id JOIN exercises ON training_sessions.exercise_id = exercises.exercise_id JOIN days ON exercises.day_id = days.day_id JOIN plans ON exercises.plan_id = plans.plan_id WHERE exercises.exercise_name = ?',
      [exerciseName],
    );
    return sessions;
  }

  //Setters
  Future<void> setTrainingSession(String exerciseName, int day) async {
    final Database database = await dbProvider.database;

    final int exerciseID = await _getExerciseID(exerciseName, day);
    database.insert('training_sessions', {
      'exercise_id': exerciseID,
    });
  }

  Future<void> setExerciseRepetitions(
    String exerciseName,
    int day,
    int reps,
    double weight,
    String date,
  ) async {
    final Database database = await dbProvider.database;
    final int exerciseID = await _getExerciseID(exerciseName, day);
    final int sessionID = await _getTrainingSessionID(exerciseID);

    await database.insert(
      'repetitions',
      {
        'session_id': sessionID,
        'reps': reps,
        'weight': weight,
        'date': date,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future getExerciseSessions(
    String planName,
    String exerciseName,
    int day,
  ) async {
    final Database database = await dbProvider.database;

    final List<Map<String, dynamic>> sessions = await database.rawQuery(
      'SELECT repetitions.session_id, repetitions.reps, repetitions.weight FROM repetitions JOIN training_sessions ON repetitions.session_id = training_sessions.session_id JOIN exercises ON training_sessions.exercise_id = exercises.exercise_id JOIN days ON exercises.day_id = days.day_id JOIN plans ON exercises.plan_id = plans.plan_id WHERE exercises.exercise_name = ? AND days.day_id = ? AND plans.plan_name = ? ORDER BY repetitions.session_id DESC ',
      [exerciseName, day, planName],
    );

    return sessions;
  }

  Future getChartData() async {
    final Database database = await dbProvider.database;

    final List<Map<String, dynamic>> data = await database.rawQuery(
      "SELECT repetitions.weight, repetitions.reps, repetitions.date FROM repetitions WHERE repetitions.date >= date('now', '-7 days')",
    );
    return data;
  }
}
