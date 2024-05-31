class CalculateProgress {
  static double calculatePercentageChange(
    List? prevReps,
    List? prevWeight,
    List? currentReps,
    List? currentWeight,
  ) {
    double avgCurrentWeightPerRep = 0;
    double avgPreviousWeightPerRep = 0;

    if (prevReps == null ||
        prevWeight == null ||
        currentReps == null ||
        currentWeight == null) {
      throw Exception('Reps and weights must not be null');
    }

    if (_checkEquality(currentWeight) && _checkEquality(prevWeight)) {
      avgCurrentWeightPerRep = currentWeight[0];
      avgPreviousWeightPerRep = prevWeight[0];
    } else if (!_checkEquality(currentWeight) && !_checkEquality(prevWeight)) {
      avgCurrentWeightPerRep = calculateAverage(currentReps, currentWeight);
      avgPreviousWeightPerRep = calculateAverage(prevReps, prevWeight);
    } else if (_checkEquality(currentWeight) && !_checkEquality(prevWeight)) {
      avgCurrentWeightPerRep = currentWeight[0];
      avgPreviousWeightPerRep = calculateAverage(prevReps, prevWeight);
    } else if (!_checkEquality(currentWeight) && _checkEquality(prevWeight)) {
      avgCurrentWeightPerRep = calculateAverage(currentReps, currentWeight);
      avgPreviousWeightPerRep = prevWeight[0];
    }

    return (((avgCurrentWeightPerRep - avgPreviousWeightPerRep) /
                avgPreviousWeightPerRep) *
            100)
        .roundToDouble();
  }

  static double calculateAverage(List? reps, List? weights) {
    if (reps == null || weights == null) {
      throw Exception('Reps and weights must not be null');
    }
    if (weights.length != reps.length) {
      throw Exception('Weights and reps must have the same length');
    }
    double totalWeight = 0;
    int totalReps = reps.reduce((prev, current) => prev + current);

    for (int i = 0; i < weights.length; i++) {
      totalWeight += weights[i] * reps[i];
    }
    return totalWeight / totalReps;
  }

  static _checkEquality(List list) {
    return list.every((element) => element == list[0]);
  }
}
