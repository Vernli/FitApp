import 'package:app/buisness/action/base_action.dart';
import 'package:flutter/foundation.dart';

@immutable
class InitExerciseAction implements BaseAction {
  const InitExerciseAction();
}

@immutable
class ExerciseGetTrainingSessionAction implements BaseAction {
  const ExerciseGetTrainingSessionAction();
}

@immutable
class ExerciseSetSessionAction implements BaseAction {
  final String exerciseName;
  final int excerciseDay;
  final List<List<dynamic>> exerciseReps;

  const ExerciseSetSessionAction({
    required this.exerciseName,
    required this.exerciseReps,
    required this.excerciseDay,
  });
}

@immutable
class ExerciseGetAllSessionsAction implements BaseAction {
  final String exerciseName;
  const ExerciseGetAllSessionsAction({required this.exerciseName});
}
