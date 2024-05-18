import 'package:app/presentation/widgets/components/plan_exercises.dart';
import 'package:flutter/material.dart';

class PlanAddTabPage extends StatefulWidget {
  final String day;
  final List<PlanExercises> exercises;
  final Function(int, int) onOrderChanged;
  final Function(PlanExercises) onRemoveExercise;
  const PlanAddTabPage({
    super.key,
    required this.day,
    required this.exercises,
    required this.onOrderChanged,
    required this.onRemoveExercise,
  });

  @override
  State<PlanAddTabPage> createState() => _PlanAddTabPageState();
}

class _PlanAddTabPageState extends State<PlanAddTabPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Expanded(
          child: ReorderableListView(
            onReorder: widget.onOrderChanged,
            children: [
              for (final exercise in widget.exercises)
                Card(
                  color: Theme.of(context).colorScheme.secondary,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black54, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  key: ValueKey(exercise),
                  child: ListTile(
                    // key: ValueKey(tile),
                    title: Text(
                      exercise.exerciseName,
                      style: const TextStyle(
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${exercise.series}x${exercise.minReps}/${exercise.maxReps}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // TODO Add edit logic
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            widget.onRemoveExercise(exercise);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
