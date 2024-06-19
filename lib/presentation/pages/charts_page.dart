import 'package:app/buisness/action/diet_action.dart';
import 'package:app/buisness/action/exercise_action.dart';
import 'package:app/buisness/bloc/diet_bloc.dart';
import 'package:app/buisness/bloc/exercise_bloc.dart';
import 'package:app/buisness/states/diet_state.dart';
import 'package:app/buisness/states/exercise_state.dart';
import 'package:app/presentation/widgets/charts_widget/chart_info.dart';
import 'package:app/presentation/widgets/components/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({super.key});

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  @override
  Widget build(BuildContext newContext) {
    return Container(
      color: Theme.of(newContext).colorScheme.secondary,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).padding.top,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).colorScheme.primary,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  child: Text(
                    'Wykresy',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.none,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          BlocProvider(
            create: (context) =>
                ExerciseBloc()..add(const ExerciseGetChartDataAction()),
            child: BlocBuilder<ExerciseBloc, ExerciseState>(
              builder: (context, state) {
                if (state is GetRepetitionsDataState) {
                  List<dynamic> data = state.repetitionsData;
                  Map<String, Map<String, dynamic>> groupedData = {};
                  for (var item in data) {
                    String date = item['date'];
                    if (!groupedData.containsKey(date)) {
                      groupedData[date] = {
                        'weight': 0,
                        'reps': 0,
                        'date': date,
                      };
                    }
                    groupedData[date]!['weight'] += item['weight'];
                    groupedData[date]!['reps'] += item['reps'];
                  }

                  List<Map<String, dynamic>> result = [];

                  groupedData.forEach((date, data) {
                    double ratio = data['weight'] / data['reps'];
                    result.add({
                      'date': date,
                      'value': ratio,
                    });
                  });
                  // //test
                  // List<Map<String, dynamic>> result = [
                  //   {'date': '2024-06-10', 'value': 17.45},
                  //   {'date': '2024-06-12', 'value': 38.83},
                  //   {'date': '2024-06-14', 'value': 46.76},
                  //   {'date': '2024-06-16', 'value': 58.75},
                  // ];
                  return CustomCard(
                    child: ChartInfo(
                      title: 'Wykres średniego cieżaru na powtórzenie',
                      data: result,
                      isCaloriesChart: false,
                    ),
                  );
                }
                return const CustomCard(
                  child: Text('x'),
                );
              },
            ),
          ),
          const SizedBox(
            height: 64,
          ),
          BlocProvider(
            create: (context) => DietBloc()..add(LoadLastWeekAction()),
            child: BlocBuilder<DietBloc, DietState>(
              builder: (context, state) {
                if (state is LoadedLastWeekState) {
                  List<dynamic> data = state.data;
                  Map<String, Map<String, dynamic>> groupedData = {};

                  for (var item in data) {
                    String date = item['date'];
                    if (!groupedData.containsKey(date)) {
                      groupedData[date] = {
                        'date': date,
                        'kcal': 0,
                      };
                    }
                    groupedData[date]!['kcal'] += item['kcal'];
                  }
                  List<Map<String, dynamic>> result = [];
                  groupedData.forEach((date, data) {
                    double kcal = data['kcal'];
                    result.add({
                      'date': date,
                      'value': kcal,
                    });
                  });
                  //test
                  // List<Map<String, dynamic>> result = [
                  //   {'date': '2024-06-10', 'value': 2117.45},
                  //   {'date': '2024-06-11', 'value': 1938.83},
                  //   {'date': '2024-06-12', 'value': 2238.83},
                  //   {'date': '2024-06-13', 'value': 2038.83},
                  //   {'date': '2024-06-14', 'value': 2146.76},
                  //   {'date': '2024-06-15', 'value': 2246.76},
                  //   {'date': '2024-06-16', 'value': 2408.75},
                  // ];

                  return CustomCard(
                    child: ChartInfo(
                      title: 'Wykres spożycia kalorii',
                      data: result,
                      isCaloriesChart: true,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
