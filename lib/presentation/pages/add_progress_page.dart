import 'package:app/buisness/action/exercise_action.dart';
import 'package:app/buisness/action/plan_action.dart';
import 'package:app/buisness/bloc/exercise_bloc.dart';
import 'package:app/buisness/bloc/plan_bloc.dart';
import 'package:app/presentation/widgets/components/controllers/picker_controller.dart';
import 'package:app/presentation/widgets/plan_widgets/plan_appbar.dart';
import 'package:app/presentation/widgets/plan_widgets/progress/add_repetitions_picker.dart';
import 'package:app/presentation/widgets/plan_widgets/progress/add_weight_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProgressPage extends StatefulWidget {
  final String planName;
  final String exerciseName;
  final int exerciseDay;

  const AddProgressPage({
    super.key,
    required this.exerciseName,
    required this.exerciseDay,
    required this.planName,
  });

  @override
  State<AddProgressPage> createState() => _AddProgressPageState();
}

class _AddProgressPageState extends State<AddProgressPage> {
  // List to store the repetitions and weight of the exercise
  // Index of this list is a set_number
  List<List<dynamic>> setsList = [];
  late ScrollController _scrollController;
  late PickerContoller _repetitionsController;
  late PickerContoller _weightController;
  final bool failed = false;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _repetitionsController = PickerContoller(pickerValue: 1);
    _weightController = PickerContoller(pickerValue: 1.0);
  }

  @override
  void dispose() {
    setsList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> safeAreaPadding = {
      'paddingTop': MediaQuery.of(context).padding.top,
      'paddingBottom': MediaQuery.of(context).padding.bottom,
    };

    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.secondary,
        child: Column(
          children: [
            PlanAddAppbar(
              title: widget.exerciseName,
              paddingTop: safeAreaPadding['paddingTop']!,
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              height: 250,
              margin: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSecondary,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 2,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AddRepetitionsPicker(
                    contoller: _repetitionsController,
                    title: 'Powtórzenia:',
                  ),
                  AddWeightPicker(
                    title: 'Cieżar (kg):',
                    contoller: _weightController,
                  ),
                  SizedBox(
                    height: 28,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_scrollController.position.maxScrollExtent != 0) {
                          _scrollController.animateTo(
                            (_scrollController.position.maxScrollExtent + 125),
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );
                        }
                        setState(() {
                          setsList.add([
                            _repetitionsController.pickerValue,
                            _weightController.pickerValue,
                          ]);
                        });
                      },
                      child: const Text(
                        'Dodaj',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: setsList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).colorScheme.primary,
                      borderRadius: index == 0 && index == setsList.length - 1
                          ? const BorderRadius.all(Radius.circular(20))
                          : index == setsList.length - 1
                              ? const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )
                              : const BorderRadius.all(Radius.circular(0)),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        'Seria ${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Powtórzeń: ${setsList[index][0]}, Cieżar: ${setsList[index][1]}',
                      ),
                      trailing: IconButton(
                        onPressed: () => setState(() {
                          setsList.removeAt(index);
                        }),
                        icon: const Icon(Icons.remove),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 12,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<ExerciseBloc>().add(
                        ExerciseSetSessionAction(
                          planName: widget.planName,
                          exerciseName: widget.exerciseName,
                          exerciseReps: setsList,
                          excerciseDay: widget.exerciseDay,
                        ),
                      );

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                child: const Text(
                  'Zapisz',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              height: safeAreaPadding['paddingBottom']!,
            ),
          ],
        ),
      ),
    );
  }
}
