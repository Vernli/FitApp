import 'package:app/buisness/action/base_action.dart';
import 'package:flutter/foundation.dart';

@immutable
class WeightSetAction implements BaseAction {
  final double weight;
  final String date;

  const WeightSetAction({required this.weight, required this.date});
}

@immutable
class WeightGetAction implements BaseAction {
  const WeightGetAction();

  get weight => null;
}
