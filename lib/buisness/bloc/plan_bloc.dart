import 'package:app/buisness/action/base_action.dart';
import 'package:app/buisness/action/plan_action.dart';
import 'package:app/buisness/states/plan_state.dart';
import 'package:app/data/models/plan/plan_model.dart';
import 'package:app/data/repositories/plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanBloc extends Bloc<BaseAction, PlanState> {
  final PlanRepository _planRepository = PlanRepository();

  PlanBloc() : super(InitPlanState()) {
    on<PlanAddAction>((event, emit) async {
      emit(LoadingPlanState());

      bool isPlanExist =
          await _planRepository.checkIfPlanExists(event.planName);
      if (isPlanExist) {
        emit(AddFailurePlanState());

        Map<String, dynamic> plan = await _planRepository.getLastPlan();

        if (plan.isEmpty) {
          emit(InitPlanState());
        } else {
          List<String> planNames = await _planRepository.getAllPlans();
          emit(
            GetPlanState(
              plan['plan']['plan_name'],
              plan['exercises'],
              planNames,
            ),
          );
        }
        return;
      }

      await _planRepository.insertPlan(
        PlanModel(
          planName: event.planName,
          exercises: event.exercises,
          createdDate: event.date,
          createdTime: event.time,
        ),
      );

      Map<String, dynamic> plan = await _planRepository.getLastPlan();
      List<String> planNames = await _planRepository.getAllPlans();
      emit(
        GetPlanState(plan['plan']['plan_name'], plan['exercises'], planNames),
      );

      emit(AddSuccessPlanState());
      emit(
        GetPlanState(plan['plan']['plan_name'], plan['exercises'], planNames),
      );
    });

    on<InitPlanAction>((event, emit) async {
      emit(LoadingPlanState());
      Map<String, dynamic> plan = await _planRepository.getLastPlan();
      List<String> planNames = await _planRepository.getAllPlans();

      if (plan.isEmpty) {
        emit(InitPlanState());
      } else {
        emit(
          GetPlanState(plan['plan']['plan_name'], plan['exercises'], planNames),
        );
      }
    });
    on<ChangePlanAction>((event, emit) async {
      emit(LoadingPlanState());
      if (event.planName == null) {
        emit(InitPlanState());
        return;
      }
      Map<String, dynamic> plan =
          await _planRepository.getPlanByName(event.planName!);
      List<String> planNames = await _planRepository.getAllPlans();
      emit(
        GetPlanState(plan['plan']['plan_name'], plan['exercises'], planNames),
      );
    });
  }
}
