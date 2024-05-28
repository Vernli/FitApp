import 'dart:async';
import 'package:app/data/database/app_database.dart';
import 'package:app/data/models/plan/plan_model.dart';
import 'package:sqflite/sqflite.dart';

class PlanDAO {
  final AppDatabase dbProvider;

  PlanDAO([AppDatabase? dbProvider])
      : dbProvider = dbProvider ?? AppDatabase.dbProvider;

  Future<List<Map<String, dynamic>>> getAllPlans() async {
    final database = await dbProvider.database;
    final List<Map<String, dynamic>> plansMaps = await database.query('plans');
    return plansMaps;
  }

  Future<void> insertPlan({required PlanModel planModel}) async {
    final database = await dbProvider.database;

    await database.insert(
      'plans',
      {
        'plan_name': planModel.planName,
        'created_date': planModel.createdDate,
        'created_time': planModel.createdTime,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    int planID = await _getPlanID(planModel.planName);
    if (planModel.exercises != null) {
      for (var element in planModel.exercises!.keys) {
        for (var exercise in planModel.exercises![element]!) {
          await database.insert(
            'exercises',
            {
              'plan_id': planID,
              'day_id': element,
              'exercise_name': exercise.exerciseName,
              'min_reps': exercise.minReps,
              'max_reps': exercise.maxReps,
              'sets': exercise.sets,
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      }
    }
  }

  Future<int> _getPlanID(String planName) async {
    final database = await dbProvider.database;
    final List<Map<String, dynamic>> planID = await database.query(
      'plans',
      where: 'plan_name = ?',
      whereArgs: [planName],
    );
    return planID[0]['plan_id'];
  }

  Future<int> _getExerciseID(String exerciseName, int day) async {
    final database = await dbProvider.database;
    final List<Map<String, dynamic>> exercises = await database.query(
      'exercises',
      where: 'exercise_name = ? AND day_id = ?',
      whereArgs: [exerciseName, day],
    );
    return exercises[0]['exercise_id'];
  }

  Future<Map<String, dynamic>> getLastPlan() async {
    final Database database = await dbProvider.database;
    final DateTime currentTime = DateTime.now();
    final lastPlan = await database.rawQuery(
      '''
      SELECT plan_id, plan_name, created_date, created_time FROM plans
      WHERE created_date <= ?
      ORDER BY created_date DESC, created_time DESC
      LIMIT 1
    ''',
      [currentTime.toString()],
    );

    if (lastPlan.isEmpty) {
      return {};
    }

    final int planID = int.parse(lastPlan[0]['plan_id'].toString());

    final List<Map<String, dynamic>> exercises = await database.rawQuery(
      '''
      SELECT day_id, exercise_name, min_reps, max_reps, sets FROM exercises
      WHERE plan_id = $planID
      ORDER BY day_id ASC
      ''',
    );

    return {
      'plan': lastPlan[0],
      'exercises': exercises,
    };
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
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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
}
