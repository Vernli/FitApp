import 'package:flutter/material.dart';

class ProgressBox extends StatelessWidget {
  const ProgressBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: const Center(
        child: Text(
          '14%',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // TODO calculate progress
  double getProgress(List<Map<String, dynamic>> currentExercises,
      List<Map<String, dynamic>> previousExercises) {
    return 0;
  }
}
