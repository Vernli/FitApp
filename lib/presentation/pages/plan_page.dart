import 'package:app/buisness/bloc/plan_bloc.dart';
import 'package:app/buisness/states/plan_state.dart';
import 'package:app/presentation/pages/add_plan_page.dart';
import 'package:app/presentation/widgets/plan_widgets/exercises/exerscie_tile.dart';
import 'package:app/presentation/widgets/plan_widgets/plan_button.dart';
import 'package:app/presentation/widgets/plan_widgets/week_days_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 48,
            padding: const EdgeInsets.all(2),
            color: Theme.of(context).colorScheme.secondary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // TODO
                PlanButton(
                  text: 'Zmień plan',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Column(
                            children: [
                              SizedBox(
                                child: TextButton(
                                  onPressed: () {},
                                  child: const Text('Plan'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(16),
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: BlocBuilder<PlanBloc, PlanState>(
                      builder: (context, state) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.planName.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                PlanButton(
                  text: 'Dodaj plan',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<PlanBloc>(context),
                          child: const AddPlanPage(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<PlanBloc, PlanState>(
            builder: (context, state) {
              int maxDayId = 0;
              Map<int, List<Map<String, dynamic>>> exercises =
                  _unwrapExercises(state.exercises!);
              for (int i = 0; i < state.exercises!.length; i++) {
                if (state.exercises![i]['day_id'] > maxDayId) {
                  maxDayId = state.exercises![i]['day_id'];
                }
              }
              maxDayId = maxDayId < 6 ? 5 : 7;

              return WeekDaysTab(
                weekDays: maxDayId < 6
                    ? ['Pon', 'Wt', 'Śr', 'Czw', 'Pt']
                    : ['Pon', 'Wt', 'Śr', 'Czw', 'Pt', 'Sob', 'Nie'],
                tabLength: maxDayId,
                tabBarPages: [
                  for (int i = 1; i <= maxDayId; i++)
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (exercises.containsKey(i))
                              for (var exercise in exercises[i]!)
                                ExerciseTile(
                                  exerciseName: exercise['exercise_name'],
                                  sets: exercise['sets'],
                                  maxReps: exercise['max_reps'],
                                  minReps: exercise['min_reps'],
                                  exerciseDay: i,
                                ),
                          ],
                        ),
                      ),
                    ),
                ],
                isBottomButton: false,
                contentHeight: (MediaQuery.of(context).size.height * 0.75 - 22),
              );
            },
          ),
        ],
      ),
    );
  }

  Map<int, List<Map<String, dynamic>>> _unwrapExercises(
    List<dynamic> exercisesData,
  ) {
    Map<int, List<Map<String, dynamic>>> exercises = {};
    for (var exercise in exercisesData) {
      int dayID = exercise['day_id'];
      if (exercises.containsKey(dayID)) {
        exercises[dayID]!.add({
          'exercise_name': exercise['exercise_name'],
          'min_reps': exercise['min_reps'],
          'max_reps': exercise['max_reps'],
          'sets': exercise['sets'],
        });
      } else {
        exercises[dayID] = [
          {
            'exercise_name': exercise['exercise_name'],
            'min_reps': exercise['min_reps'],
            'max_reps': exercise['max_reps'],
            'sets': exercise['sets'],
          }
        ];
      }
    }
    return exercises;
  }
}
