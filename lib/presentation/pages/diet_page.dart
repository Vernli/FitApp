import 'package:app/buisness/action/diet_action.dart';
import 'package:app/buisness/bloc/diet_bloc.dart';
import 'package:app/buisness/states/diet_state.dart';
import 'package:app/presentation/widgets/diet_widgets/diet_date_picker.dart';
import 'package:app/presentation/widgets/diet_widgets/diet_day_info.dart';
import 'package:app/presentation/widgets/diet_widgets/diet_tile_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DietDatePicker(
          onDateChanged: (date) {
            context.read<DietBloc>().add(
                  ReadMealAction(date: DateFormat('yyyy-MM-dd').format(date)),
                );
            setState(() {
              this.date = DateFormat('yyyy-MM-dd').format(date);
            });
          },
        ),
        BlocBuilder<DietBloc, DietState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            switch (state) {
              case InitDietState():
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      DietTileBuilder.empty(date: date),
                      const DietDayInfo.empty(),
                    ],
                  ),
                );
              case LoadedDietState():
                Map<String, double> totalScore = {
                  'kcal': 0,
                  'proteins': 0,
                  'carbs': 0,
                  'fat': 0,
                };
                Map<String, int> goal = state.goal;
                if (state.nutrientsScore.isNotEmpty) {
                  for (var score in state.nutrientsScore.values) {
                    totalScore['kcal'] =
                        (totalScore['kcal'] ?? 0) + (score['kcal'] ?? 0);
                    totalScore['proteins'] = (totalScore['proteins'] ?? 0) +
                        (score['proteins'] ?? 0);
                    totalScore['carbs'] =
                        (totalScore['carbs'] ?? 0) + (score['carbs'] ?? 0);
                    totalScore['fat'] =
                        (totalScore['fat'] ?? 0) + (score['fat'] ?? 0);
                  }
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      DietTileBuilder(
                        date: date,
                        contentData: state.meals,
                        nutrientsScoreData: state.nutrientsScore,
                      ),
                      DietDayInfo(
                        totalScore: totalScore,
                        goal: goal,
                      ),
                    ],
                  ),
                );
              case LoadingDietState():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case LoadedLastWeekState():
                return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
