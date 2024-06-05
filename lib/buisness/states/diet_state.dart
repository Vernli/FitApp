import 'package:app/data/models/diet/meal_model.dart';

sealed class DietState {}

final class InitDietState extends DietState {}

final class DietLoadingState extends DietState {}

final class DietLoadedState extends DietState {
  final Map<String, List<MealModel>> meals;
  final Map<String, Map<String, double>> nutrientsScore;
  DietLoadedState({required this.nutrientsScore, required this.meals});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DietLoadedState &&
        other.meals == meals &&
        other.nutrientsScore == nutrientsScore;
  }

  @override
  int get hashCode => super.hashCode;
}
