import 'package:app/models/base_model.dart';

class WeightModel extends BaseModel {
  final double weight;
  final String date;

  const WeightModel({
    required this.weight,
    required this.date,
  });

  @override
  String toString() {
    return 'WeightModel {weight: $weight, date: $date}';
  }

  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'date': date,
    };
  }

  factory WeightModel.fromMap(Map<String, dynamic> map) {
    return WeightModel(
      weight: map['weight'],
      date: map['date'],
    );
  }
}
