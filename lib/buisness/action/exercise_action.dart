import 'package:app/buisness/action/base_action.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

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
  final String date;

  const ExerciseSetSessionAction({
    required this.planName,
    required this.exerciseName,
    required this.exerciseReps,
    required this.excerciseDay,
    required this.date,
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

@immutable
class ExerciseGetChartDataAction implements BaseAction {
  const ExerciseGetChartDataAction();
}
