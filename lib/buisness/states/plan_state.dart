import 'package:app/data/models/plan/exercise_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class PlanState {
  final bool isLoading;
  final String? planName; // planName
  final List? exercises; // data
  final Error? error; // error

  const PlanState({
    required this.isLoading,
    required this.planName,
    this.exercises,
    this.error,
  });
  @override
  const PlanState.loading()
      : isLoading = true,
        planName = null,
        exercises = null,
        error = null;

  @override
  const PlanState.empty()
      : planName = null,
        isLoading = false,
        exercises = null,
        error = null;

  @override
  String toString() {
    return {
      'isLoading': isLoading,
      'planName': planName,
      'exercise': exercises,
      'error': error,
    }.toString();
  }

  PlanState copyWith({
    bool? isLoading,
    String? planName,
    List<ExerciseModel>? exercises,
    Error? error,
  }) {
    return PlanState(
      isLoading: isLoading ?? this.isLoading,
      planName: planName ?? this.planName,
      exercises: exercises ?? this.exercises,
      error: error ?? this.error,
    );
  }
}
