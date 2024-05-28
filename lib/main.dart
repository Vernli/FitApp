import 'package:app/buisness/action/plan_action.dart';
import 'package:app/buisness/action/weight_action.dart';
import 'package:app/buisness/bloc/plan_bloc.dart';
import 'package:app/buisness/bloc/weight_bloc.dart';
import 'package:app/config/theme/app_theme.dart';
import 'package:app/presentation/screens/plan_screen.dart';
import 'package:app/presentation/widgets/components/tab_appbar.dart';
import 'package:app/presentation/screens/weight_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dziennik Treningowy',
      theme: appTheme,
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WeightBloc>(
          lazy: true,
          create: (BuildContext context) =>
              WeightBloc()..add(const InitWeightAction()),
        ),
        BlocProvider(
          lazy: true,
          create: (BuildContext context) =>
              PlanBloc()..add(const InitPlanAction()),
        ),
      ],
      child: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const TabAppBar(
            tabs: [
              Tab(
                text: 'Dieta',
              ),
              Tab(
                text: 'Trening',
              ),
              Tab(
                text: 'Waga',
              ),
            ],
          ),
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Center(child: Text('Dieta')),
              Center(child: PlanScreen<PlanBloc>()),
              Center(child: WeightScreen<WeightBloc>()),
            ],
          ),
          extendBodyBehindAppBar: false,
          // TODO - IMPLEMENTACJA FUNKCJONALNOŚCI
          floatingActionButton: FloatingActionButton(
            onPressed: () => {},
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.bar_chart_rounded),
          ),
        ),
      ),
    );
  }
}
