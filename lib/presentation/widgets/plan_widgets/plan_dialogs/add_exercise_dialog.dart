import 'package:app/presentation/widgets/components/controllers/picker_controller.dart';
import 'package:app/presentation/widgets/components/plan_exercises.dart';
import 'package:app/presentation/widgets/plan_widgets/add_exercise_card.dart';
import 'package:app/presentation/widgets/plan_widgets/plan_dialogs/widgets/add_plan_picker.dart';
import 'package:flutter/material.dart';

class AddExerciseDialog extends StatefulWidget {
  final Function onAddExercise;
  const AddExerciseDialog({super.key, required this.onAddExercise});
  final int _maxSeries = 14;
  final int _maxReps = 31;

  @override
  State<AddExerciseDialog> createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<AddExerciseDialog> {
  final TextEditingController _textController = TextEditingController();
  final PickerContoller seriesPicker = PickerContoller(pickerValue: 1);
  final PickerContoller minRepsPicker = PickerContoller(pickerValue: 1);
  final PickerContoller maxRepsPicker = PickerContoller(pickerValue: 1);
  bool isTextEmpty = false;
  int currentMaxValue = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 500,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black.withOpacity(0.9), width: 2),
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        child: Column(
          children: [
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
              child: const Center(
                child: Text(
                  'Dodawanie ćwiczenia',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                // height = total_dialog_height - titlebar - padding
                height: 500 - 48 - 16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AddExerciseCard(
                      child: TextField(
                        controller: _textController,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          hintText: 'Nazwa ćwiczenia',
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    // Series picker
                    AddExerciseCard(
                      child: AddPlanPicker(
                        contoller: seriesPicker,
                        maxPickerValue: widget._maxSeries,
                        title: 'Ilość serii',
                      ),
                    ),
                    // Min reps picker
                    AddExerciseCard(
                      child: AddPlanPicker(
                        contoller: minRepsPicker,
                        maxPickerValue: currentMaxValue,
                        title: 'Min. ilość powtórzeń',
                      ),
                    ),
                    // Max reps picker
                    AddExerciseCard(
                      child: AddPlanPicker(
                        contoller: maxRepsPicker,
                        maxPickerValue: widget._maxReps,
                        onChanged: (value) {
                          setState(() {
                            currentMaxValue = value;
                          });
                        },
                        title: 'Max. ilość pwotórzeń',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 42.0),
                      child: Container(
                        width: double.infinity,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 1,
                                offset: Offset(0, 2),
                              ),
                            ]),
                        child: ElevatedButton(
                          onPressed: () {
                            // Check if the text field is empty or contains only whitespaces
                            if (_textController.text.isEmpty ||
                                _textController.text.trim().isEmpty) {
                              setState(() {
                                isTextEmpty = true;
                                _textController.clear();
                              });
                              return;
                            } else {
                              widget.onAddExercise(
                                PlanExercises(
                                  exerciseName: _textController.text,
                                  series: seriesPicker.pickerValue,
                                  minReps: minRepsPicker.pickerValue,
                                  maxReps: maxRepsPicker.pickerValue,
                                ),
                              );
                              Navigator.pop(context);

                              return;
                            }
                          },
                          child: const Text(
                            'Dodaj  ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
