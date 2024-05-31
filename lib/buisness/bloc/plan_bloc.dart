import 'package:app/buisness/action/base_action.dart';
import 'package:app/buisness/action/plan_action.dart';
import 'package:app/buisness/states/plan_state.dart';
import 'package:app/data/models/plan/plan_model.dart';
import 'package:app/data/repositories/plan_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanBloc extends Bloc<BaseAction, PlanState> {
  final PlanRepository _planRepository = PlanRepository();

  PlanBloc() : super(const PlanState.empty()) {
    on<PlanAddAction>((event, emit) async {
      emit(const PlanState.loading());
      await _planRepository.insertPlan(
        PlanModel(
          planName: event.planName,
          exercises: event.exercises,
          createdDate: event.date,
          createdTime: event.time,
        ),
      );
      Map<String, dynamic> plan = await _planRepository.getLastPlan();
      emit(
        PlanState(
          isLoading: false,
          planName: plan['plan']['plan_name'],
          exercises: plan['exercises'],
        ),
      );
    });

    on<InitPlanAction>((event, emit) async {
      emit(const PlanState.loading());
      Map<String, dynamic> plan = await _planRepository.getLastPlan();
      if (plan.isEmpty) {
        emit(const PlanState.empty());
      } else {
        emit(
          PlanState(
            isLoading: false,
            planName: plan['plan']['plan_name'],
            exercises: plan['exercises'],
          ),
        );
      }
    });
  }
}
