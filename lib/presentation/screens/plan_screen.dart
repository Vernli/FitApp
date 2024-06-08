import 'package:app/buisness/bloc/plan_bloc.dart';
import 'package:app/buisness/states/plan_state.dart';
import 'package:app/presentation/pages/add_plan_page.dart';
import 'package:app/presentation/pages/plan_page.dart';
import 'package:app/presentation/pages/startup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanScreen<T extends PlanBloc> extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlanBloc, PlanState>(
      builder: (context, state) {
        switch (state) {
          case InitPlanState():
            return StartupPage(
                onPressed: () {
                  return Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<PlanBloc>(context),
                        child: const AddPlanPage(),
                      ),
                    ),
                  );
                },
                labelTitle: 'Dodaj plan treningowy');
          case LoadingPlanState():
            return const CircularProgressIndicator();
          case GetPlanState(:final planNames):
            return PlanPage(planNames: planNames);
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
