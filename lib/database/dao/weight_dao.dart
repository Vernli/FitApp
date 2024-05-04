import 'package:app/database/app_database.dart';
import 'package:app/models/weight/weight_model.dart';
import 'package:sqflite/sqflite.dart';

class WeightDAO {
  final AppDatabase dbProvider;

  WeightDAO([AppDatabase? dbProvider])
      : dbProvider = dbProvider ?? AppDatabase.dbProvider;

  Future<void> insertWeight({required WeightModel weight}) async {
    final database = await dbProvider.database;
    await database.insert(
      'weight',
      weight.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<WeightModel>> getAllWeights() async {
    final database = await dbProvider.database;
    final List<Map<String, dynamic>> weightMaps =
        await database.query('weight');
    final List<WeightModel> weights = [];
    for (final weightMap in weightMaps) {
      final WeightModel weight = WeightModel.fromMap(weightMap);
      weights.add(weight);
    }
    return weights;
  }
}
