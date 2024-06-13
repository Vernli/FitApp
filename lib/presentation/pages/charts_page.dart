import 'package:app/buisness/action/diet_action.dart';
import 'package:app/buisness/action/plan_action.dart';
import 'package:app/buisness/bloc/diet_bloc.dart';
import 'package:app/buisness/bloc/plan_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({super.key});

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PlanBloc>(
          lazy: true,
          create: (BuildContext context) =>
              PlanBloc()..add(const InitPlanAction()),
        ),
        BlocProvider<DietBloc>(
          lazy: true,
          create: (BuildContext context) => DietBloc()
            ..add(
              InitDietAction(
                DateFormat('yyyy-MM-dd').format(DateTime.now()),
              ),
            ),
        ),
      ],
      child: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
