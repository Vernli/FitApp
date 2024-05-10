import 'package:app/buisness/action/base_action.dart';
import 'package:flutter/foundation.dart';

@immutable
class WeightSetAction implements BaseAction {
  final double weight;
  final String date;
  final String time;

  const WeightSetAction({
    required this.weight,
    required this.date,
    required this.time,
  });
}

@immutable
class WeightGetAction implements BaseAction {
  const WeightGetAction();

  // get weight => null;
}

@immutable
class InitEvent implements BaseAction {
  const InitEvent();
}
