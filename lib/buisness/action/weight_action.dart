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

@immutable
class WeightSetCurrentWeight implements BaseAction {
  final double weight;

  const WeightSetCurrentWeight({required this.weight});
}

@immutable
class WeightGetCurrentWeight implements BaseAction {
  const WeightGetCurrentWeight();
}
