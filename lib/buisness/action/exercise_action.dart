import 'package:app/buisness/action/base_action.dart';
import 'package:flutter/foundation.dart';

@immutable
class InitExerciseAction implements BaseAction {
  const InitExerciseAction();
}

@immutable
class ExerciseSetSessionAction implements BaseAction {
  final String planName;
  final String exerciseName;
  final int excerciseDay;
  final List<List<dynamic>> exerciseReps;

  const ExerciseSetSessionAction({
    required this.planName,
    required this.exerciseName,
    required this.exerciseReps,
    required this.excerciseDay,
  });
}

@immutable
class ExerciseGetAllSessionsAction implements BaseAction {
  final String planName;
  final String exerciseName;
  const ExerciseGetAllSessionsAction({
    required this.planName,
    required this.exerciseName,
  });
}

@immutable
class ExerciseGetSessionsAction implements BaseAction {
  final String planName;
  final String exerciseName;
  final int day;
  const ExerciseGetSessionsAction({
    required this.planName,
    required this.exerciseName,
    required this.day,
  });
}
