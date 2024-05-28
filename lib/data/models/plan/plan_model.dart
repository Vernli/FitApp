import 'package:app/data/models/base_model.dart';
import 'package:app/utils/plan_exercise.dart';

class PlanModel extends BaseModel {
  final String planName;
  final String createdDate;
  final String createdTime;
  final String? updatedTime;
  final String? updatedDate;
  final Map<int, List<PlanExercise>>? exercises;

  PlanModel({
    required this.planName,
    required this.createdDate,
    required this.createdTime,
    this.updatedDate,
    this.updatedTime,
    this.exercises,
  });

  @override
  String toString() {
    return 'PlanModel {planName: $planName, createdDate: $createdDate, createdTime: $createdTime, updatedDate: $updatedDate, updatedTime: $updatedTime }';
  }

  Map<String, dynamic> toMap() {
    return {
      'planName': planName,
      'createdDate': createdDate,
      'createdTime': createdTime,
      'updatedDate': updatedDate,
      'updatedTime': updatedTime,
    };
  }

  factory PlanModel.fromMap(Map<String, dynamic> map) {
    return PlanModel(
      planName: map['plan_name'],
      createdDate: map['created_date'],
      createdTime: map['created_time'],
      updatedDate: map['updated_date'],
      updatedTime: map['updated_time'],
    );
  }
}
