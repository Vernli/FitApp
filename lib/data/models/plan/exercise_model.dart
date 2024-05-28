import 'package:app/data/models/base_model.dart';

class ExerciseModel extends BaseModel {
  final String day;
  final String exerciseName;
  final int sets;
  final int minReps;
  final int maxReps;

  ExerciseModel({
    required this.day,
    required this.exerciseName,
    required this.sets,
    required this.minReps,
    required this.maxReps,
  });

  @override
  String toString() {
    return 'ExerciseModel {day: $day, exerciseName: $exerciseName, sets: $sets, minReps: $minReps, maxReps: $maxReps}';
  }

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      day: map['day_id'],
      exerciseName: map['exercise_name'],
      sets: map['sets'],
      minReps: map['min_reps'],
      maxReps: map['max_reps'],
    );
  }
}
