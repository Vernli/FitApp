import 'dart:ffi';

import 'package:app/data/models/base_model.dart';

class ProgressModel extends BaseModel {
  final int progressID;
  final int exerciseID;
  final Float weight;
  final int reps;
  final List<int> sets;

  ProgressModel({
    required this.progressID,
    required this.exerciseID,
    required this.weight,
    required this.reps,
    required this.sets,
  });

  @override
  String toString() {
    return 'ProgressModel {progressID: $progressID, exerciseID: $exerciseID, weight: $weight, reps: $reps, sets: $sets}';
  }
}
