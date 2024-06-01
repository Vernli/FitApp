sealed class PlanState {}

final class InitPlanState extends PlanState {}

final class LoadingPlanState extends PlanState {}

final class GetPlanState extends PlanState {
  final String planName;
  final List exercisesList;
  GetPlanState(this.planName, this.exercisesList);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetPlanState &&
        other.planName == planName &&
        other.exercisesList == exercisesList;
  }

  @override
  int get hashCode => super.hashCode;
}

final class AddSuccessPlanState extends PlanState {}

final class AddFailurePlanState extends PlanState {
  AddFailurePlanState();
}
