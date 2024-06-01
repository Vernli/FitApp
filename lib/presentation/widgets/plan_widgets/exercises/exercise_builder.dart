import 'package:app/presentation/widgets/plan_widgets/exercises/exerscie_tile.dart';
import 'package:flutter/material.dart';

class ExerciseBuilder extends StatefulWidget {
  final int day;
  final String planName;
  final List<Map<String, dynamic>>? exercises;
  const ExerciseBuilder({
    super.key,
    required this.exercises,
    required this.day,
    required this.planName,
  });

  @override
  State<ExerciseBuilder> createState() => _ExerciseBuilderState();
}

class _ExerciseBuilderState extends State<ExerciseBuilder> {
  int selectedTile = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: Key(selectedTile.toString()),
      shrinkWrap: true,
      itemCount: widget.exercises!.length,
      itemBuilder: (context, index) {
        final exercise = widget.exercises![index].values.toList();
        return ExerciseTile(
          key: Key(index.toString()),
          planName: widget.planName,
          exerciseName: exercise[0],
          exerciseDay: widget.day,
          sets: exercise[3],
          maxReps: exercise[2],
          minReps: exercise[1],
          initiallyExpanded: index == selectedTile,
          onExpansionChanged: ((newState) {
            if (newState!) {
              setState(() {
                selectedTile = index;
              });
            } else {
              setState(() {
                selectedTile = -1;
              });
            }
          }),
        );
      },
    );
  }
}
