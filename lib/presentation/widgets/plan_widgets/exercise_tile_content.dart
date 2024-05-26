import 'package:app/presentation/widgets/plan_widgets/progress_box.dart';

import 'package:app/presentation/widgets/plan_widgets/exercise_value_box.dart';
import 'package:flutter/material.dart';

class ExerciseTileContent extends StatelessWidget {
  const ExerciseTileContent({Key? key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 220,
          child: Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: [
              ExerciseValueBox(value: 7),
              ExerciseValueBox(value: 7),
              ExerciseValueBox(value: 7),
              ExerciseValueBox(value: 7),
              ExerciseValueBox(value: 7),
              ExerciseValueBox(value: 7),
            ],
          ),
        ),
        ExerciseValueBox(value: 15, isWeight: true),
        SizedBox(
          width: 4,
        ),
        ProgressBox(),
      ],
    );
  }
}
