import 'package:app/data/models/diet/meal_model.dart';
import 'package:app/data/models/diet/meal_nutrient_model.dart';

class SQLResultFormatter {
  static get mealData => null;

  static Map<int, Map<String, List<dynamic>>> sessionResultFormat(
    List<Map<String, dynamic>> rawData,
  ) {
    Map<int, Map<String, List<dynamic>>> formattedData = {};
    for (var value in rawData) {
      int sessionID = value['session_id'];
      if (formattedData.containsKey(sessionID)) {
        formattedData[sessionID]!['reps']!.add(value['reps']);
        formattedData[sessionID]!['weights']!.add(value['weight']);
      } else {
        formattedData[sessionID] = {
          'reps': [value['reps']],
          'weights': [value['weight']],
        };
      }
    }
    return formattedData;
  }

  static Map<String, Map<String, double>> mealNutrientResultFormat(
    List<Map<String, dynamic>> queryResult,
  ) {
    Map<String, Map<String, double>> resultMap = {};

    for (var result in queryResult) {
      String mealTypeName = result['meal_type_name'].toString();
      resultMap[mealTypeName] = {
        'proteins': double.parse(result['proteins'].toString()),
        'carbs': double.parse(result['carbs'].toString()),
        'fat': double.parse(result['fat'].toString()),
        'kcal': double.parse(result['kcal'].toString()),
      };
    }
    return resultMap;
  }

  static Map<String, List<MealModel>> mealResultFormat(
    List<Map<String, dynamic>> queryResult,
  ) {
    Map<String, List<MealModel>> resultMap = {};
    for (var meal in queryResult) {
      String mealTypeName = meal['meal_type_name'];
      MealModel mealModel = MealModel(
        mealName: meal['meal_name'],
        mealType: mealTypeName,
        nutrients: [
          MealNutrientModel(
            proteins: meal['proteins'],
            carbs: meal['carbs'],
            fat: meal['fat'],
            kcal: meal['kcal'],
          ),
        ],
      );

      if (!resultMap.containsKey(mealTypeName)) {
        resultMap[mealTypeName] = [];
      }

      resultMap[mealTypeName]!.add(mealModel);
    }

    return resultMap;
  }
}
