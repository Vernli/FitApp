// meal_nutrient_model.dart
class MealNutrientModel {
  final double proteins;
  final double carbs;
  final double fat;
  final double kcal;

  MealNutrientModel({
    required this.proteins,
    required this.carbs,
    required this.fat,
    required this.kcal,
  });

  factory MealNutrientModel.fromMap(Map<String, dynamic> map) {
    return MealNutrientModel(
      proteins: map['proteins'],
      carbs: map['carbs'],
      fat: map['fat'],
      kcal: map['kcal'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'proteins': proteins,
      'carbs': carbs,
      'fat': fat,
      'kcal': kcal,
    };
  }
}
