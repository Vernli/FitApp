import 'package:app/presentation/widgets/components/plan_exercises.dart';
import 'package:app/presentation/widgets/plan_widgets/plan_add_tab_page.dart';
import 'package:app/presentation/widgets/plan_widgets/plan_appbar.dart';
import 'package:app/presentation/widgets/plan_widgets/week_days_tab.dart';
import 'package:flutter/material.dart';

class AddPlanPage extends StatefulWidget {
  final String planName;
  const AddPlanPage({super.key, required this.planName});

  @override
  State<AddPlanPage> createState() => _AddPlanPageState();
}

class _AddPlanPageState extends State<AddPlanPage> {
  List<String> weekDays = [
    'Pon',
    'Wt',
    'Śr',
    'Czw',
    'Pt',
    'Sob',
    'Nie',
  ];

  List<List<PlanExercises>> exercises = List.generate(7, (index) => []);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> safeAreaPadding = {
      'paddingTop': MediaQuery.of(context).padding.top,
      'paddingBottom': MediaQuery.of(context).padding.bottom,
    };
    // Calculate the free area for the content of the page
    double safeAreaHeight = MediaQuery.of(context).size.height -
        safeAreaPadding['paddingTop']! -
        safeAreaPadding['paddingBottom']! -
        106;

    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.secondary,
        child: Column(
          children: [
            PlanAddAppbar(
              title: widget.planName,
              paddingTop: safeAreaPadding['paddingTop']!,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: safeAreaHeight,
              margin: const EdgeInsets.only(
                top: 8,
              ),
              color: Theme.of(context).colorScheme.secondary,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: WeekDaysTab(
                      weekDays: [...weekDays],
                      tabBarPages: weekDays
                          .map(
                            (day) => PlanAddTabPage(
                              day: day,
                              exercises: exercises[weekDays.indexOf(day)],
                              onOrderChanged: (oldIndex, newIndex) {
                                setState(() {
                                  int index = weekDays.indexOf(day);

                                  if (oldIndex < newIndex) {
                                    newIndex--;
                                  }
                                  final exercise =
                                      exercises[index].removeAt(oldIndex);
                                  exercises[index].insert(newIndex, exercise);
                                });
                              },
                              onRemoveExercise: (value) {
                                int index = weekDays.indexOf(day);
                                setState(() {
                                  exercises[index].remove(value);
                                });
                              },
                            ),
                          )
                          .toList(),
                      contentHeight:
                          (MediaQuery.of(context).size.height * 0.75 - 88),
                      isBottomButton: true,
                      onAddExercise: (index, value) {
                        setState(() {
                          exercises[index].add(value);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                child: const Text(
                  'Dodaj plan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              height: safeAreaPadding['paddingBottom']!,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
