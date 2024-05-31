import 'package:app/data/models/base_model.dart';

class ExerciseModel extends BaseModel {
  final List<int>? reps;
  final List<double>? weights;

  ExerciseModel({
    required this.reps,
    required this.weights,
  });

  @override
  String toString() {
    return {
      'reps': reps,
      'weights': weights,
    }.toString();
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      reps: List<int>.from(map['reps']),
      weights: List<double>.from(map['weight']),
    );
  }
}
