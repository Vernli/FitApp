import 'package:app/data/database/dao/exercise_dao.dart';

class ExerciseRepository {
  final ExerciseDAO _exerciseDAO = ExerciseDAO();

  ExerciseRepository();

  // Future<List<Map<String, dynamic>>> getAllWeights() async =>
  //     await _weightDao.getAllWeights();

  // Future<void> insertWeight(WeightModel weight) async =>
  //     await _weightDao.insertWeight(weight: weight);
}
