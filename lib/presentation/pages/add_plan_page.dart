import 'package:app/buisness/action/plan_action.dart';
import 'package:app/buisness/bloc/plan_bloc.dart';
import 'package:app/buisness/states/plan_state.dart';
import 'package:app/presentation/widgets/components/custom_alert_dialog.dart';
import 'package:app/utils/current_date.dart';
import 'package:app/utils/plan_exercise.dart';
import 'package:app/presentation/widgets/plan_widgets/plan_add_tab_page.dart';
import 'package:app/presentation/widgets/plan_widgets/plan_appbar.dart';
import 'package:app/presentation/widgets/plan_widgets/week_days_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlanPage extends StatefulWidget {
  const AddPlanPage({super.key});

  @override
  State<AddPlanPage> createState() => _AddPlanPageState();
}

class _AddPlanPageState extends State<AddPlanPage> {
  TextEditingController textController = TextEditingController();
  List<String> weekDays = [
    'Pon',
    'Wt',
    'Śr',
    'Czw',
    'Pt',
    'Sob',
    'Nie',
  ];

  /// Generates an empty list of exercises for each day of the week.
  List<List<PlanExercise>> exercises = List.generate(7, (index) => []);
  bool isExersiceEmpty = true;
  String planTitle = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _askForPlanName();
    });
  }

  @override
  void dispose() {
    exercises.clear();
    weekDays.clear();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double bottomHeight = 64;

    Map<String, double> safeAreaPadding = {
      'paddingTop': MediaQuery.of(context).padding.top,
      'paddingBottom': MediaQuery.of(context).padding.bottom,
    };

    double safeAreaHeight =
        safeAreaPadding['paddingTop']! + safeAreaPadding['paddingBottom']!;

    double contentHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom -
        24 -
        48 -
        64 -
        54;

    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.secondary,
        child: SingleChildScrollView(
          child: Column(
            children: [
              PlanAddAppbar(
                paddingTop: safeAreaPadding['paddingTop']!,
                title: planTitle,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height -
                    safeAreaHeight -
                    bottomHeight -
                    24,
                margin: const EdgeInsets.only(
                  top: 8,
                ),
                color: Theme.of(context).colorScheme.secondary,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: WeekDaysTab(
                        tabLength: 7,
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
                                    isExersiceEmpty = checkIsExerciseEmpty();
                                  });
                                },
                              ),
                            )
                            .toList(),
                        contentHeight: contentHeight,
                        isBottomButton: true,
                        checkIsExerciseExists: (index, value) {
                          for (var element in exercises[index]) {
                            if (element.exerciseName == value) {
                              return true;
                            }
                          }
                          return false;
                        },
                        onAddExercise: (index, value) {
                          setState(() {
                            exercises[index].add(value);
                            isExersiceEmpty = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: bottomHeight,
                child: BlocListener<PlanBloc, PlanState>(
                  listener: (context, state) {
                    if (state is AddFailurePlanState) {
                      showDialog(
                        context: context,
                        builder: (context) => const CustomAlertDialog(
                          title: 'Nie można dodać planu',
                          subtitle: 'Plan o podanej nazwie już istnieje!',
                        ),
                      );
                    } else if (state is AddSuccessPlanState) {
                      Navigator.pop(context);
                    }
                  },
                  child: ElevatedButton(
                    onPressed: () {
                      if (isExersiceEmpty || planTitle.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) => const CustomAlertDialog(
                            title: 'Nie można dodać pustego planu',
                            subtitle: 'Dodaj ćwiczenie!',
                          ),
                        );
                      } else {
                        context.read<PlanBloc>().add(
                              PlanAddAction(
                                planName: planTitle,
                                exercises: getExercises(),
                                date: CurrentDate.getDate()['date']!,
                                time: CurrentDate.getDate()['time']!,
                              ),
                            );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 0,
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool checkIsExerciseEmpty() {
    for (int i = 0; i < weekDays.length; i++) {
      if (exercises[i].isNotEmpty) {
        return false;
      }
    }
    return true;
  }

  Map<int, List<PlanExercise>> getExercises() {
    Map<int, List<PlanExercise>> exercisesMap = {};
    for (int i = 0; i < weekDays.length; i++) {
      if (exercises[i].isNotEmpty) {
        exercisesMap[i + 1] = exercises[i];
      }
    }
    return exercisesMap;
  }

  void _askForPlanName() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (newContext) => Dialog(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 2,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.black,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        insetPadding: const EdgeInsets.all(0),
        child: SizedBox(
          height: 224,
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Dialog title
              Container(
                width: double.infinity,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 1,
                      offset: Offset(0, 2),
                    ),
                  ],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // double pop to leave add_plan_page
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const Center(
                      child: Text(
                        'Wprowadzanie planu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Text field for plan name with limit of 18 characters
              SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    maxLength: 48,
                    autocorrect: false,
                    controller: textController,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      hintText: 'Wprawadź nazwę planu',
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // show error message if the text field is empty
              Container(
                width: 120,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    if (textController.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (newContext) => const CustomAlertDialog(
                          title: 'Nie można dodać pustego planu',
                          subtitle: 'Dodaj nazwę planu!',
                        ),
                      );
                      return;
                    }
                    BlocProvider.of<PlanBloc>(context).add(
                      PlanCheckPlanAction(
                        planName: textController.text,
                      ),
                    );
                    setState(() {
                      planTitle = textController.text;
                      textController.clear();
                    });
                    // Navigator.pop(context);
                  },
                  child: const Text(
                    'Dalej',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),

              // Empty space at the bottom to align the button
              const SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
