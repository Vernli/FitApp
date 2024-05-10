import 'package:app/data/database/dao/weight_dao.dart';
import 'package:app/data/models/weight/weight_model.dart';

class WeightRepository {
  final WeightDAO weightDao = WeightDAO();

  WeightRepository();

  Future<List<Map<String, dynamic>>> getAllWeights() async =>
      await weightDao.getAllWeights();

  Future<void> insertWeight(WeightModel weight) async =>
      await weightDao.insertWeight(weight: weight);

  // Future updateWeight(WeightModel weight) async => weightDao.updateWeight(weight);

  // Future deleteWeightById(int id) async => weightDao.deleteWeightById(id);
}
