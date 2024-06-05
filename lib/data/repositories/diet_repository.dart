import 'package:app/data/database/dao/diet_dao.dart';
import 'package:app/data/models/diet/meal_model.dart';
import 'package:app/data/sql_result_formatter.dart';

class DietRepository {
  final DietDAO _dietDAO = DietDAO();

  DietRepository();

  Future<Map<String, Map<String, double>>> getTotalNutrients(date) async {
    dynamic totalNutrients = await _dietDAO.getTotalNutrients(date);
    return SQLResultFormatter.mealNutrientResultFormat(totalNutrients);
  }

  Future<Map<String, List<MealModel>>> getAllMeals(date) async {
    dynamic allMeals = await _dietDAO.getAllMeals(date);
    return SQLResultFormatter.mealResultFormat(allMeals);
  }

  Future<void> addMeal({
    required String mealName,
    required String mealType,
    required String date,
    required double kcal,
    required double carbs,
    required double protein,
    required double fat,
  }) async {
    await _dietDAO.addMeal(
      mealName: mealName,
      mealType: mealType,
      date: date,
      kcal: kcal,
      carbs: carbs,
      protein: protein,
      fat: fat,
    );
  }
}
