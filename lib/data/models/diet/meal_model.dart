// meal_model.dart
import 'meal_nutrient_model.dart';

class MealModel {
  final String mealName;
  final String mealType;
  final List<MealNutrientModel> nutrients;

  MealModel({
    required this.mealName,
    required this.mealType,
    required this.nutrients,
  });

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      mealName: map['meal_name'],
      mealType: map['meal_type_name'],
      nutrients: (map['nutrients'] as List<dynamic>)
          .map((e) => MealNutrientModel.fromMap(e))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'meal_name': mealName,
      'meal_type_name': mealType,
      'nutrients': nutrients.map((e) => e.toMap()).toList(),
    };
  }
}
