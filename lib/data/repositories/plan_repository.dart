import 'package:app/data/database/dao/plan_dao.dart';
import 'package:app/data/models/plan/plan_model.dart';

class PlanRepository {
  final PlanDAO _planDAO = PlanDAO();

  PlanRepository();

  Future<List<Map<String, dynamic>>> getAllPlans() async =>
      await _planDAO.getAllPlans();

  Future<void> insertPlan(PlanModel plan) async {
    await _planDAO.insertPlan(planModel: plan);
  }

  Future<Map<String, dynamic>> getLastPlan() async {
    Map<String, dynamic> plan = await _planDAO.getLastPlan();
    return plan;
  }

  Future<void> setTrainingSession(String exerciseName, int day) async {
    await _planDAO.setTrainingSession(exerciseName, day);
  }

  Future<void> setExerciseRepetitions(
    String exerciseName,
    int day,
    int reps,
    double weight,
  ) async {
    await _planDAO.setExerciseRepetitions(exerciseName, day, reps, weight);
  }

  Future<List<Map<String, dynamic>>> getExerciseRepetitions(
    String exerciseName,
    int day,
  ) async {
    return await _planDAO.getExerciseRepetitions(exerciseName, day);
  }
}
