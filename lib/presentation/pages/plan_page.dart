import 'package:app/presentation/widgets/plan_widgets/plan_button.dart';
import 'package:app/presentation/widgets/plan_widgets/plan_dialogs/set_plan_name_dialog.dart';
import 'package:app/presentation/widgets/plan_widgets/week_days_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Map<String, dynamic>> tab_exercise = [
      {
        'name': 'Wyciskanie hantli na ławce płaskiej',
        'sets': 4,
        'reps': '5-7',
      },
      {
        'name': 'OHP',
        'sets': 4,
        'reps': '5-7',
      },
      {
        'name': 'Przysiad klasyczny',
        'sets': 4,
        'reps': '5-7',
      },
      {
        'name': 'Unoszenie hantli bokiem',
        'sets': 3,
        'reps': '8-10',
      },
      {
        'name': 'Rozpiętki',
        'sets': 3,
        'reps': '8-10',
      },
      {
        'name': 'Wyciskanie francuskie sztangielek za głowę',
        'sets': 3,
        'reps': '8-12',
      },
    ];

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
                PlanButton(text: 'Zmień plan', onPressed: () {}),
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
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Workout 1',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                PlanButton(
                  text: 'Dodaj plan',
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const SetPlanNameDialog();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          WeekDaysTab(
            weekDays: const ['Pon', 'Wt', 'Śr', 'Czw', 'Pt', 'Sob', 'Nie'],
            tabBarPages: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    for (final exercise in tab_exercise)
                      ExpansionTile(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          // trailing: Text(exercise['sets'].toString() +
                          //     'x' +
                          //     exercise['reps'].toString()),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(exercise['name']),
                              Text(exercise['sets'].toString() +
                                  'x' +
                                  exercise['reps'].toString()),
                            ],
                          ),
                          children: [
                            for (int i = 0; i < exercise['sets']; i++)
                              ListTile(
                                title: Text('Seria ${i + 1}'),
                                subtitle:
                                    Text('Powtórzenia: ${exercise['reps']}'),
                              )
                          ]),
                  ])),
              Center(child: Text('Wt')),
              Center(child: Text('Śr')),
              Center(child: Text('Czw')),
              Center(child: Text('Pt')),
              Center(child: Text('Sob')),
              Center(child: Text('Nie')),
            ],
            isBottomButton: false,
            contentHeight: (MediaQuery.of(context).size.height * 0.75 - 22),
          ),
        ],
      ),
    );
  }
}
