import 'package:app/data/models/base_model.dart';

class WeightModel extends BaseModel {
  final double weight;
  final String date;
  final String time;

  const WeightModel({
    required this.weight,
    required this.date,
    required this.time,
  });

  @override
  String toString() {
    return 'WeightModel {weight: $weight, date: $date, time: $time}';
  }

  Map<String, dynamic> toMap() {
    return {
      'weight': weight,
      'date': date,
      'time': time,
    };
  }

  factory WeightModel.fromMap(Map<String, dynamic> map) {
    return WeightModel(
      weight: map['weight'],
      date: map['date'],
      time: map['time'],
    );
  }
}
