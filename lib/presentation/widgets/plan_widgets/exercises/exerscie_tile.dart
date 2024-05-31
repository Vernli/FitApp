import 'package:app/buisness/action/exercise_action.dart';
import 'package:app/buisness/bloc/exercise_bloc.dart';
import 'package:app/buisness/states/exercise_state.dart';
import 'package:app/presentation/pages/add_progress_page.dart';
import 'package:app/presentation/widgets/components/custom_square_box.dart';
import 'package:app/presentation/widgets/plan_widgets/exercise_values_box.dart';
import 'package:app/presentation/widgets/plan_widgets/exercises/progress_box.dart';
import 'package:app/presentation/widgets/plan_widgets/exercises/repetitions_weight_box.dart';
import 'package:app/utils/calculate_proggres.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseTile extends StatefulWidget {
  final String exerciseName;
  final int exerciseDay;
  final int sets;
  final int maxReps;
  final int minReps;
  final bool initiallyExpanded;
  final Function onExpansionChanged;
  const ExerciseTile({
    super.key,
    required this.exerciseName,
    required this.exerciseDay,
    required this.sets,
    required this.maxReps,
    required this.minReps,
    required this.initiallyExpanded,
    required this.onExpansionChanged,
  });

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  bool areAllElementsEqual = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: widget.initiallyExpanded,
      onExpansionChanged: (value) {
        if (value) {
          context.read<ExerciseBloc>().add(
                ExerciseGetAllSessionsAction(
                  exerciseName: widget.exerciseName,
                ),
              );
          widget.onExpansionChanged(value);
        }
      },
      backgroundColor: Theme.of(context).colorScheme.secondary,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${widget.exerciseName} - ${widget.sets}x${widget.minReps}-${widget.maxReps}',
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<ExerciseBloc>(context),
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
        BlocBuilder<ExerciseBloc, ExerciseState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            switch (state) {
              case LoadingExerciseState():
                return const SizedBox(
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );

              case GetExerciseState(:final exerciseData):
                return Column(
                  children: [
                    for (var exerciseKey in exerciseData.keys)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSecondary,
                          border: const Border(
                            top: BorderSide(color: Colors.white38, width: 1),
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 200,
                              child: _areAllElementsEqual(
                                exerciseData[exerciseKey]!['weights'],
                              )
                                  ? ExerciseValuesBox(
                                      repetitions:
                                          exerciseData[exerciseKey]!['reps'],
                                    )
                                  : RepetitionsWeightBox(
                                      repetitions:
                                          exerciseData[exerciseKey]!['reps'],
                                      weights:
                                          exerciseData[exerciseKey]!['weights'],
                                    ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 100,
                              child: Wrap(
                                runSpacing: 8,
                                children: [
                                  areAllElementsEqual
                                      ? CustomSquareBox(
                                          textValue: exerciseData[exerciseKey]![
                                                  'weights']![0]
                                              .toString(),
                                        )
                                      : const SizedBox(),
                                  SizedBox(),
                                  exerciseKey != 1
                                      ? ProgressBox(
                                          percentageProgress: CalculateProgress
                                              .calculatePercentageChange(
                                            exerciseData[exerciseKey - 1]![
                                                'reps'],
                                            exerciseData[exerciseKey - 1]![
                                                'weights'],
                                            exerciseData[exerciseKey]!['reps'],
                                            exerciseData[exerciseKey]![
                                                'weights'],
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),

                            //TODO
                            SizedBox(
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.remove),
                              ),
                            ),
                          ],
                        ),
                      ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).colorScheme.onSecondary,
                      child: TextButton(
                        // TODO ON PRESSED MOVE TO NEW PAGE
                        onPressed: () {},
                        child: const Icon(
                          Icons.more_horiz,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                  ],
                );

              default:
                return const SizedBox(child: Text('Brak danych'));
            }
          },
        ),
      ],
    );
  }

  bool _areAllElementsEqual(List? listWeights) {
    if (listWeights == null) return false;
    areAllElementsEqual =
        listWeights.every((element) => element == listWeights.first);

    return areAllElementsEqual;
  }
}
