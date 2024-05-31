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
}
