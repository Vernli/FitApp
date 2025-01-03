import 'package:sqflite/sqflite.dart';

class DietTables {
  static const String mealTypeTable = 'meal_type';
  static const String mealsTable = 'meal';
  static const String mealNutrientTable = 'meal_nutrient';
  static const String goalTable = 'calories_goal';

  static const Map<String, String> createQuery = {
    mealTypeTable: '''
      CREATE TABLE IF NOT EXISTS $mealTypeTable (
      meal_type_id INTEGER PRIMARY KEY AUTOINCREMENT,
      meal_type_name TEXT NOT NULL
      );''',
    mealNutrientTable: '''
      CREATE TABLE IF NOT EXISTS $mealNutrientTable (
      nutrient_id INTEGER PRIMARY KEY AUTOINCREMENT,
      meal_id INTEGER NOT NULL UNIQUE,
      proteins REAL NOT NULL,
      carbs REAL NOT NULL,
      fat REAL NOT NULL,
      kcal REAL NOT NULL,
      FOREIGN KEY (meal_id) REFERENCES meal(meal_id)
    );''',
    mealsTable: '''
      CREATE TABLE IF NOT EXISTS $mealsTable (
      meal_id INTEGER PRIMARY KEY AUTOINCREMENT,
      meal_type_id INTEGER NOT NULL,
      meal_name TEXT NOT NULL,
      date TEXT NOT NULL,
      FOREIGN KEY (meal_type_id) REFERENCES $mealTypeTable(meal_type_id)
    );''',
    goalTable: '''
      CREATE TABLE IF NOT EXISTS $goalTable (
      goal_id INTEGER PRIMARY KEY AUTOINCREMENT,
      proteins INTEGER NOT NULL,
      carbs INTEGER NOT NULL,
      fat INTEGER NOT NULL,
      kcal INTEGER NOT NULL
    );''',
  };

  static const insertMealTypesQuery = '''
    INSERT INTO $mealTypeTable (meal_type_name) VALUES
    ('Śniadanie'),
    ('Drugie śniadanie'),
    ('Obiad'),
    ('Podwieczorek'),
    ('Kolacja'),
    ('Przekąska');
  ''';

  static void createTable(Database database, int version) async {
    await database.execute(createQuery[mealTypeTable]!);
    await database.execute(createQuery[mealNutrientTable]!);
    await database.execute(createQuery[mealsTable]!);
    await database.execute(createQuery[mealNutrientTable]!);
    await database.execute(createQuery[goalTable]!);
    await database.execute(insertMealTypesQuery);
  }
}
