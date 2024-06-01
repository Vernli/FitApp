class CalculateProgress {
  static double calculatePercentageChange(
    List? prevReps,
    List? prevWeight,
    List? currentReps,
    List? currentWeight,
  ) {
    double currentTotalWeight = 0;
    double previousTotalWeight = 0;

    if (prevReps == null ||
        prevWeight == null ||
        currentReps == null ||
        currentWeight == null) {
      throw Exception('Reps and weights must not be null');
    }

    if (_checkEquality(currentWeight) && _checkEquality(prevWeight)) {
      currentTotalWeight =
          currentWeight[0] * currentReps.reduce((a, b) => a + b);
      previousTotalWeight = prevWeight[0] * prevReps.reduce((a, b) => a + b);
    } else if (!_checkEquality(currentWeight) && !_checkEquality(prevWeight)) {
      currentTotalWeight = calculateTotalWeight(currentReps, currentWeight);
      previousTotalWeight = calculateTotalWeight(prevReps, prevWeight);
    } else if (_checkEquality(currentWeight) && !_checkEquality(prevWeight)) {
      currentTotalWeight =
          currentWeight[0] * currentReps.reduce((a, b) => a + b);
      previousTotalWeight = calculateTotalWeight(prevReps, prevWeight);
    } else if (!_checkEquality(currentWeight) && _checkEquality(prevWeight)) {
      currentTotalWeight = calculateTotalWeight(currentReps, currentWeight);
      previousTotalWeight = prevWeight[0] * prevReps.reduce((a, b) => a + b);
    }

    return ((currentTotalWeight - previousTotalWeight) /
            previousTotalWeight *
            100)
        .roundToDouble();
  }

  static double calculateTotalWeight(List? reps, List? weights) {
    if (reps == null || weights == null) {
      throw Exception('Reps and weights must not be null');
    }
    if (weights.length != reps.length) {
      throw Exception('Weights and reps must have the same length');
    }
    double totalWeight = 0;
    for (int i = 0; i < weights.length; i++) {
      totalWeight += weights[i] * reps[i];
    }
    return totalWeight;
  }

  static _checkEquality(List list) {
    return list.every((element) => element == list[0]);
  }
}
