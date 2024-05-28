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
        if (state.isLoading) {
          return const CircularProgressIndicator();
        }
        if (state.planName == null) {
          return const StartupPlanPage();
        }
        return const PlanPage();
      },
      buildWhen: (previous, current) => previous != current,
    );
  }
}
