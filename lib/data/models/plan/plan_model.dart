import 'package:app/data/models/base_model.dart';

class PlanModel extends BaseModel {
  final int id;
  final String planName;
  final String createdAt;
  final String updatedAt;

  PlanModel({
    required this.id,
    required this.planName,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'PlanModel {id: $id, planName: $planName, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
