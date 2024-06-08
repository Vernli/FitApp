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

  Future<void> setCalorieGoal({
    required int proteins,
    required int carbs,
    required int fat,
    required int kcal,
  }) async {
    await _dietDAO.setCaloriesGoal(
      proteins: proteins,
      carbs: carbs,
      fat: fat,
      kcal: kcal,
    );
  }

  Future<dynamic> getCalorieGoal() async {
    final rawCaloriesGoal = await _dietDAO.getCalorieGoal();
    if (rawCaloriesGoal.isEmpty) {
      return [];
    }
    final Map<String, int> caloriesGoal = {
      'proteins': int.parse(rawCaloriesGoal[0]['proteins'].toString()),
      'carbs': int.parse(rawCaloriesGoal[0]['carbs'].toString()),
      'fat': int.parse(rawCaloriesGoal[0]['fat'].toString()),
      'kcal': int.parse(rawCaloriesGoal[0]['kcal'].toString()),
    };

    return caloriesGoal;
  }

  Future<void> updateCalorieGoal({
    required int proteins,
    required int carbs,
    required int fat,
    required int kcal,
  }) async {
    await _dietDAO.updateCaloriesGoal(
      kcal: kcal,
      carbs: carbs,
      proteins: proteins,
      fat: fat,
    );
  }
}
