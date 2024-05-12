import 'package:app/data/models/base_model.dart';

class ExerciseModel extends BaseModel {
  final int exerciseID;
  final int workoutDayID;
  final String exerciseName;
  final int sets;
  final int minReps;
  final int maxReps;

  ExerciseModel({
    required this.exerciseID,
    required this.workoutDayID,
    required this.exerciseName,
    required this.sets,
    required this.minReps,
    required this.maxReps,
  });

  @override
  String toString() {
    return 'ExerciseModel {exerciseID: $exerciseID, workoutDayID: $workoutDayID, exerciseName: $exerciseName, sets: $sets, minReps: $minReps, maxReps: $maxReps}';
  }
}
