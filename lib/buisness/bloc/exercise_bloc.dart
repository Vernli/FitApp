import 'package:app/buisness/action/base_action.dart';
import 'package:app/buisness/action/exercise_action.dart';
import 'package:app/buisness/states/exercise_state.dart';
import 'package:app/data/repositories/exercise_repository.dart';
import 'package:app/data/sql_result_formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseBloc extends Bloc<BaseAction, ExerciseState> {
  final ExerciseRepository _exerciseRepository = ExerciseRepository();

  ExerciseBloc() : super(InitExerciseState()) {
    on<ExerciseSetSessionAction>((event, emit) async {
      await _exerciseRepository.setTrainingSession(
        event.exerciseName,
        event.excerciseDay,
      );
      for (List<dynamic> element in event.exerciseReps) {
        await _exerciseRepository.setExerciseRepetitions(
          event.exerciseName,
          event.excerciseDay,
          element[0],
          element[1],
        );
      }
      emit(LoadingExerciseState());
      final Map<int, Map<String, List<dynamic>>> trainingSessions =
          SQLResultFormatter.sessionResultFormat(
        await _exerciseRepository.getAllTrainingSessions(event.exerciseName),
      );
      emit(GetExerciseState(trainingSessions));
    });

    on<ExerciseGetSessionsAction>((event, emit) async {
      emit(LoadingExerciseState());
      final List<Map<String, dynamic>> lastThreeSessions =
          await _exerciseRepository.getExerciseSessions(
        event.planName,
        event.exerciseName,
        event.day,
      );
      final Map<int, Map<String, List<dynamic>>> formattedResult =
          SQLResultFormatter.sessionResultFormat(
        lastThreeSessions,
      );
      emit(GetExerciseState(formattedResult));
    });
  }
}
