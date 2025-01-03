import 'package:app/data/database/app_database.dart';
import 'package:sqflite/sqflite.dart';

class DietDAO {
  final AppDatabase dbProvider;

  DietDAO([AppDatabase? dbProvider])
      : dbProvider = dbProvider ?? AppDatabase.dbProvider;

  Future<dynamic> getTotalNutrients(date) async {
    final database = await dbProvider.database;
    final queryResult = await database.rawQuery('''
    SELECT mt.meal_type_name, SUM(mn.proteins) as proteins, SUM(mn.carbs) as carbs, SUM(mn.fat) as fat, SUM(mn.kcal) as kcal
    FROM meal_type mt
    JOIN meal m ON mt.meal_type_id = m.meal_type_id
    JOIN meal_nutrient mn ON m.meal_id = mn.meal_id
    WHERE m.date = '$date'
    GROUP BY mt.meal_type_name
''');
    return queryResult;
  }

  Future<dynamic> getAllMeals(date) async {
    final database = await dbProvider.database;
    final queryResult = await database.rawQuery('''
    SELECT m.meal_name, mt.meal_type_name, mn.proteins, mn.carbs, mn.fat, mn.kcal
    FROM meal m
    JOIN meal_type mt ON m.meal_type_id = mt.meal_type_id
    JOIN meal_nutrient mn ON m.meal_id = mn.meal_id
    WHERE m.date = '$date'
    ''');
    return queryResult;
  }

  Future<dynamic> loadLastWeek() async {
    final database = await dbProvider.database;
//     final queryResult = await database.rawQuery('''
// // "SELECT repetitions.weight, repetitions.reps, repetitions.date FROM repetitions WHERE
// //repetitions.date >= date('now', '-7 days')");

// ''');
    final queryResult = await database.rawQuery('''
    SELECT kcal, date
    FROM meal m
    JOIN meal_type mt ON m.meal_type_id = mt.meal_type_id
    JOIN meal_nutrient mn ON m.meal_id = mn.meal_id
    WHERE m.date >= date('now', '-7 days')
    ''');
    return queryResult;
  }

  Future<dynamic> getCalorieGoal() async {
    final database = await dbProvider.database;
    final queryResult = await database
        .query(columns: ['proteins', 'carbs', 'fat', 'kcal'], 'calories_goal');

    return queryResult;
  }

  Future<void> setCaloriesGoal({
    required int proteins,
    required int carbs,
    required int fat,
    required int kcal,
  }) async {
    final database = await dbProvider.database;
    await database.insert(
      'calories_goal',
      {
        'proteins': proteins,
        'carbs': carbs,
        'fat': fat,
        'kcal': kcal,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateCaloriesGoal({
    required int kcal,
    required int carbs,
    required int proteins,
    required int fat,
  }) async {
    final database = await dbProvider.database;
    await database.update(
      'calories_goal',
      {
        'kcal': kcal,
        'carbs': carbs,
        'proteins': proteins,
        'fat': fat,
      },
    );
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
    final database = await dbProvider.database;

    final int mealTypeID = await getMealTypeID(mealType);

    await database.insert(
      'meal',
      {
        'meal_name': mealName,
        'date': date,
        'meal_type_id': mealTypeID,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await database.insert('meal_nutrient', {
      'meal_id': await getMealID(mealName, date, mealTypeID),
      'proteins': protein,
      'carbs': carbs,
      'fat': fat,
      'kcal': kcal,
    });
  }

  Future<int> getMealTypeID(String mealType) async {
    final database = await dbProvider.database;
    final List<Map<String, dynamic>> mealTypeID = await database.query(
      'meal_type',
      where: 'meal_type_name = ?',
      whereArgs: [mealType],
    );

    return mealTypeID[0]['meal_type_id'];
  }

  Future<int> getMealID(String mealName, String date, int mealTypeID) async {
    final database = await dbProvider.database;
    final List<Map<String, dynamic>> mealID = await database.query(
      'meal',
      columns: ['meal_id'],
      where: 'meal_name = ? AND date = ? AND meal_type_id = ?',
      whereArgs: [mealName, date, mealTypeID],
    );

    return mealID.last['meal_id'];
  }
}
