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
    JOIN meal_nutrition mn ON m.meal_id = mn.meal_id
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
    JOIN meal_nutrition mn ON m.meal_id = mn.meal_id
    WHERE m.date = '$date'
    ''');
    return queryResult;
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

    await database.insert('meal_nutrition', {
      'meal_id': await getMealID(mealName),
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

  Future<int> getMealID(String mealName) async {
    final database = await dbProvider.database;
    final List<Map<String, dynamic>> mealID = await database.query(
      'meal',
      where: 'meal_name = ?',
      whereArgs: [mealName],
    );
    return mealID[0]['meal_id'];
  }
}
