import 'package:app/buisness/action/diet_action.dart';
import 'package:app/buisness/action/plan_action.dart';
import 'package:app/buisness/action/weight_action.dart';
import 'package:app/buisness/bloc/diet_bloc.dart';
import 'package:app/buisness/bloc/plan_bloc.dart';
import 'package:app/buisness/bloc/weight_bloc.dart';
import 'package:app/config/theme/app_theme.dart';
import 'package:app/presentation/pages/charts_page.dart';
import 'package:app/presentation/screens/diet_screen.dart';
import 'package:app/presentation/screens/plan_screen.dart';
import 'package:app/presentation/widgets/components/tab_appbar.dart';
import 'package:app/presentation/screens/weight_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    setPortraitMode(); // prevent landscape mode
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      child: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const TabAppBar(
            tabs: [
              Tab(text: 'Kalorie'),
              Tab(text: 'Trening'),
              Tab(text: 'Waga'),
            ],
          ),
          body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              Center(child: DietScreen<DietBloc>()),
              Center(child: PlanScreen<PlanBloc>()),
              Center(child: WeightScreen<WeightBloc>()),
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.primary,
              mini: true,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChartsPage(),
                  ),
                );
              },
              child: const Icon(Icons.bar_chart_sharp),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.startDocked,
          extendBodyBehindAppBar: false,
        ),
      ),
    );
  }
}

/// Sets the preferred device orientations to portrait mode.
///
/// This function uses the `SystemChrome.setPreferredOrientations` method
/// to set the preferred orientations to portrait mode, allowing the app
/// to be displayed only in portrait orientation.
Future setPortraitMode() async {
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
}
