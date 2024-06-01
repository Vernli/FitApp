import 'package:app/buisness/bloc/plan_bloc.dart';
import 'package:app/buisness/states/plan_state.dart';
import 'package:app/presentation/pages/plan_page.dart';
import 'package:app/presentation/pages/startup_plan_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanScreen<T extends PlanBloc> extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      builder: (context, state) {
        print(state);
        switch (state) {
          case InitPlanState():
            return const StartupPlanPage();
          case LoadingPlanState():
            return const CircularProgressIndicator();
          case GetPlanState():
            return const PlanPage();
          case AddFailurePlanState():
            return const SizedBox();
          case AddSuccessPlanState():
            return const SizedBox();
        }
      },
      buildWhen: (previous, current) => previous != current,
    );
  }
}
