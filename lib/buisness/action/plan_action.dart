import 'package:app/buisness/action/base_action.dart';
import 'package:app/utils/plan_exercise.dart';
import 'package:flutter/foundation.dart';

@immutable
class InitPlanAction implements BaseAction {
  const InitPlanAction();
}

@immutable
class PlanAddAction implements BaseAction {
  final String planName;
  final Map<int, List<PlanExercise>> exercises;
  final String date;
  final String time;

  const PlanAddAction({
    required this.planName,
    required this.exercises,
    required this.date,
    required this.time,
  });
}

@immutable
class PlanCheckPlanAction implements BaseAction {
  final String planName;
  const PlanCheckPlanAction({
    required this.planName,
  });
}

@immutable
class PlanGetAction implements BaseAction {
  const PlanGetAction();
}

@immutable
class PlanGetLastAction implements BaseAction {
  const PlanGetLastAction();
}

@immutable
class PlanGetTrainingSessionAction implements BaseAction {
  const PlanGetTrainingSessionAction();
}

@immutable
class PlanSetSessionAction implements BaseAction {
  final String exerciseName;
  final int excerciseDay;
  final List<List<dynamic>> exerciseReps;

  const PlanSetSessionAction({
    required this.exerciseName,
    required this.exerciseReps,
    required this.excerciseDay,
  });
}

@immutable
class ChangePlanAction implements BaseAction {
  final String? planName;
  const ChangePlanAction({
    required this.planName,
  });
}
