import 'dart:async';
import 'dart:math';
import 'package:app/data/database/app_database.dart';
import 'package:app/data/models/plan/plan_model.dart';
import 'package:sqflite/sqflite.dart';

class PlanDAO {
  final AppDatabase dbProvider;

  PlanDAO([AppDatabase? dbProvider])
      : dbProvider = dbProvider ?? AppDatabase.dbProvider;

  Future<List<String>> getAllPlans() async {
    final database = await dbProvider.database;
    final queryResult =
        await database.rawQuery('''SELECT plan_name FROM plans''');
    return queryResult.map((e) => e['plan_name'].toString()).toList();
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

  Future<Map<String, dynamic>> getLastPlan() async {
    final Database database = await dbProvider.database;
    final lastPlan = await database.rawQuery(
      '''
      SELECT plan_id, plan_name, created_date, created_time FROM plans
      Order BY created_date, created_time DESC LIMIT 1
    ''',
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

  Future<Map<String, dynamic>> getPlanByName(String planName) async {
    final Database database = await dbProvider.database;
    final List<Map<String, dynamic>> plan = await database.query(
      'plans',
      where: 'plan_name = ?',
      whereArgs: [planName],
    );
    if (plan.isEmpty) {
      return {};
    }

    final int planID = int.parse(plan[0]['plan_id'].toString());

    final List<Map<String, dynamic>> exercises = await database.rawQuery(
      '''
      SELECT day_id, exercise_name, min_reps, max_reps, sets FROM exercises
      WHERE plan_id = $planID
      ORDER BY day_id ASC
      ''',
    );
    return {
      'plan': plan[0],
      'exercises': exercises,
    };
  }

  // DELETE PLAN
  Future<bool> deletePlan(int planID) async {
    final database = await dbProvider.database;
    final int result = await database.delete(
      'plans',
      where: 'plan_id = ?',
      whereArgs: [planID],
    );
    return result != 0;
  }

  // CHECK IF PLAN EXISTS
  Future<bool> checkIfPlanExists(String planName) async {
    final database = await dbProvider.database;
    final List<Map<String, dynamic>> result = await database.query(
      'plans',
      where: 'plan_name = ?',
      whereArgs: [planName],
    );
    return result.isNotEmpty;
  }
}
