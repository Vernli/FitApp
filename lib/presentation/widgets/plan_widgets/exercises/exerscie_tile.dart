import 'package:app/buisness/bloc/plan_bloc.dart';
import 'package:app/presentation/pages/add_progress_page.dart';
import 'package:app/presentation/widgets/plan_widgets/exercises/exercise_tile_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// BLOCK SELECT ONLY FIRST thrEE VALUES IF NEW PROGRESS IS ADD JUST ADD IT TO THE DB AND LIFO
class ExerciseTile extends StatefulWidget {
  final String exerciseName;
  final int exerciseDay;
  final int sets;
  final int maxReps;
  final int minReps;
  const ExerciseTile({
    super.key,
    required this.exerciseName,
    required this.exerciseDay,
    required this.sets,
    required this.maxReps,
    required this.minReps,
  });

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.exerciseName),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<PlanBloc>(context),
                    child: AddProgressPage(
                      exerciseName: widget.exerciseName,
                      exerciseDay: widget.exerciseDay,
                    ),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      children: [
        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   padding: const EdgeInsets.all(18),
        //   decoration: BoxDecoration(
        //     color: Theme.of(context).colorScheme.onSecondary,
        //     border:
        //         const Border(top: BorderSide(color: Colors.white38, width: 1)),
        //   ),
        //   child: Row(
        //     children: [
        //       const ExerciseTileContent(),
        //       const Spacer(),
        //       SizedBox(
        //         child: IconButton(
        //           onPressed: () {},
        //           icon: const Icon(Icons.remove),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        // Container(
        //   width: MediaQuery.of(context).size.width,
        //   color: Theme.of(context).colorScheme.onSecondary,
        //   child: TextButton(
        //     // TODO ON PRESSED MOVE TO NEW PAGE
        //     onPressed: () {},
        //     child: const Icon(
        //       Icons.more_horiz,
        //       color: Colors.white60,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
