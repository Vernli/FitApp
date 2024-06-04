import 'package:app/buisness/bloc/exercise_bloc.dart';
import 'package:app/buisness/bloc/plan_bloc.dart';
import 'package:app/buisness/states/plan_state.dart';
import 'package:app/presentation/pages/add_plan_page.dart';
import 'package:app/presentation/widgets/plan_widgets/change_plan_button.dart';
import 'package:app/presentation/widgets/plan_widgets/exercises/exercise_builder.dart';
import 'package:app/presentation/widgets/plan_widgets/plan_button.dart';
import 'package:app/presentation/widgets/plan_widgets/week_days_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlanPage extends StatelessWidget {
  final List<String> planNames;
  const PlanPage({super.key, required this.planNames});
  @override
  Widget build(BuildContext context) {
    String currentPlanName = '';
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
                ChangePlanButton(
                  planNames: planNames,
                  currentPlanName: currentPlanName,
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
                        switch (state) {
                          case LoadingPlanState():
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case InitPlanState():
                            return const Center(
                              child: Text(
                                'Brak planu',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          case GetPlanState(:final planName):
                            currentPlanName = planName;
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  planName,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          default:
                            return const SizedBox();
                        }
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
              switch (state) {
                case LoadingPlanState():
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case InitPlanState():
                  return const Center(
                    child: Text('Brak planu'),
                  );
                case GetPlanState(:final exercisesList):
                  int maxDayId = 0;
                  Map<int, List<Map<String, dynamic>>> exercises =
                      _unwrapExercises(exercisesList);
                  for (int i = 0; i < exercisesList.length; i++) {
                    if (exercisesList[i]['day_id'] > maxDayId) {
                      maxDayId = exercisesList[i]['day_id'];
                    }
                  }
                  maxDayId = maxDayId < 6 ? 5 : 7;

                  return BlocProvider(
                    create: (context) => ExerciseBloc(),
                    child: WeekDaysTab(
                      weekDays: maxDayId < 6
                          ? ['Pon', 'Wt', 'Śr', 'Czw', 'Pt']
                          : ['Pon', 'Wt', 'Śr', 'Czw', 'Pt', 'Sob', 'Nie'],
                      tabLength: maxDayId,
                      tabBarPages: [
                        for (int day = 1; day <= maxDayId; day++)
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  exercises.containsKey(day)
                                      ? ExerciseBuilder(
                                          planName: currentPlanName,
                                          exercises: exercises[day],
                                          day: day,
                                        )
                                      : SizedBox(
                                          height: 48,
                                          child: Center(
                                            child: Text(
                                              'Brak ćwiczeń',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                      ],
                      isBottomButton: false,
                      contentHeight:
                          (MediaQuery.of(context).size.height * 0.75 - 22),
                    ),
                  );
                default:
                  return const SizedBox();
              }
            },
            buildWhen: (previous, current) => previous != current,
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
