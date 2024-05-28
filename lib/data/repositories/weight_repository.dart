import 'package:app/data/database/dao/weight_dao.dart';
import 'package:app/data/models/weight/weight_model.dart';

class WeightRepository {
  final WeightDAO _weightDao = WeightDAO();

  WeightRepository();

  Future<List<Map<String, dynamic>>> getAllWeights() async =>
      await _weightDao.getAllWeights();

  Future<void> insertWeight(WeightModel weight) async =>
      await _weightDao.insertWeight(weight: weight);
}
