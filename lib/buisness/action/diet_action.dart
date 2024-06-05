// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/buisness/action/base_action.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class InitDietAction implements BaseAction {
  final String date;
  const InitDietAction(this.date);
}

@immutable
class AddMealAction implements BaseAction {
  final String mealName;
  final String mealType;
  final double kcal;
  final double carbs;
  final double proteins;
  final double fat;
  final String date;

  const AddMealAction({
    required this.mealName,
    required this.mealType,
    required this.date,
    required this.kcal,
    required this.carbs,
    required this.proteins,
    required this.fat,
  });
}

@immutable
class ReadMealAction implements BaseAction {
  final String date;

  const ReadMealAction({required this.date});
}