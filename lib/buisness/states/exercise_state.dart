sealed class ExerciseState {}

final class InitExerciseState extends ExerciseState {}

final class LoadingExerciseState extends ExerciseState {}

final class GetExerciseState extends ExerciseState {
  final Map<int, Map<String, List<dynamic>>> exerciseData;
  GetExerciseState(this.exerciseData);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetExerciseState && other.exerciseData == exerciseData;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}

final class GetRepetitionsDataState extends ExerciseState {
  final List<Map<String, dynamic>> repetitionsData;
  GetRepetitionsDataState(this.repetitionsData);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetRepetitionsDataState &&
        other.repetitionsData == repetitionsData;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
