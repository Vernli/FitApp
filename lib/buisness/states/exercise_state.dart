sealed class ExerciseState {}

final class InitExerciseState extends ExerciseState {}

final class LoadingExerciseState extends ExerciseState {}

final class GetExerciseState extends ExerciseState {
  final Map<int, Map<String, List<dynamic>>> exerciseData;
  GetExerciseState(this.exerciseData);
}
