import 'package:app/data/database/dao/plan_dao.dart';
import 'package:app/data/models/plan/plan_model.dart';

class PlanRepository {
  final PlanDAO _planDAO = PlanDAO();

  PlanRepository();

  Future<List<String>> getAllPlans() async => await _planDAO.getAllPlans();

  Future<void> insertPlan(PlanModel plan) async {
    await _planDAO.insertPlan(planModel: plan);
  }

  Future<Map<String, dynamic>> getLastPlan() async {
    Map<String, dynamic> plan = await _planDAO.getLastPlan();
    return plan;
  }

  Future<bool> checkIfPlanExists(String planName) async {
    return _planDAO.checkIfPlanExists(planName);
  }

  Future<Map<String, dynamic>> getPlanByName(String planName) async {
    return _planDAO.getPlanByName(planName);
  }
}
