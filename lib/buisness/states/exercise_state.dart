import 'package:flutter/foundation.dart';

@immutable
class ExerciseState {
  final bool isLoading; // when add is Loading? Yes when it is inserted to db
  final Object? exerciseData;
  final Error? error; // error

  const ExerciseState({
    required this.isLoading,
    required this.exerciseData,
    this.error,
  });
  @override
  const ExerciseState.loading()
      : isLoading = true,
        exerciseData = null,
        error = null;

  @override
  const ExerciseState.empty()
      : exerciseData = null,
        isLoading = false,
        error = null;

  @override
  String toString() {
    return {
      'isLoading': isLoading,
      'exerciseData': exerciseData,
      'error': error,
    }.toString();
  }

  ExerciseState copyWith({
    bool? isLoading,
    Object? exerciseData,
    Error? error,
  }) {
    return ExerciseState(
      isLoading: isLoading ?? this.isLoading,
      exerciseData: exerciseData ?? this.exerciseData,
      error: error ?? this.error,
    );
  }
}
