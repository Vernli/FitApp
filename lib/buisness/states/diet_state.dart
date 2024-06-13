import 'package:app/data/models/diet/meal_model.dart';

sealed class DietState {}

final class InitDietState extends DietState {}

final class LoadingDietState extends DietState {}

final class LoadedDietState extends DietState {
  final Map<String, List<MealModel>> meals;
  final Map<String, Map<String, double>> nutrientsScore;
  final Map<String, int> goal;
  LoadedDietState({
    required this.nutrientsScore,
    required this.meals,
    required this.goal,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadedDietState &&
        other.meals == meals &&
        other.nutrientsScore == nutrientsScore;
  }

  @override
  // ignore: unnecessary_overrides
  int get hashCode => super.hashCode;
}
