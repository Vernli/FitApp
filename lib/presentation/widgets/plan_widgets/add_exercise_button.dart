import 'package:app/presentation/widgets/plan_widgets/plan_dialogs/add_exercise_dialog.dart';
import 'package:flutter/material.dart';

class AddExerciesButton extends StatelessWidget {
  final Function onAddExercise;
  const AddExerciesButton({super.key, required this.onAddExercise});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154,
      height: 32,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: ((context) => AddExerciseDialog(
                  onAddExercise: (value) {
                    onAddExercise(value);
                  },
                )),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.90),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: Colors.black,
          elevation: 2,
        ),
        child: const Text(
          'Dodaj ćwiczenie',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
