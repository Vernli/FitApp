import 'package:app/presentation/widgets/plan_widgets/plan_button.dart';
import 'package:app/presentation/widgets/plan_widgets/plan_dialogs/set_plan_name_dialog.dart';
import 'package:app/presentation/widgets/plan_widgets/week_days_tab.dart';
import 'package:flutter/material.dart';

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
                    }),
              ],
            ),
          ),
          WeekDaysTab(
            weekDays: const ['Pon', 'Wt', 'Śr', 'Czw', 'Pt', 'Sob', 'Nie'],
            tabBarPages: const [
              Center(child: Text('Pon')),
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
