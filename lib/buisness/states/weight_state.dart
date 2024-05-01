import 'package:flutter/foundation.dart';

@immutable
class WeightState {
  final bool isLoading;
  final Object? data;
  final Object? error;
  final double? currentWeightPickerValue;
  const WeightState({
    required this.isLoading,
    required this.data,
    required this.error,
    required this.currentWeightPickerValue,
  });

  @override
  const WeightState.empty()
      : isLoading = false,
        data = null,
        error = null,
        currentWeightPickerValue = null;

  const WeightState.loading()
      : isLoading = true,
        data = null,
        error = null,
        currentWeightPickerValue = null;

  @override
  String toString() {
    return {
      'isLoading': isLoading,
      'data': data,
      'error': error,
      'curentWeightPickerValue': currentWeightPickerValue,
    }.toString();
  }
}
