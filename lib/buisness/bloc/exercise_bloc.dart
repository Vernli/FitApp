import 'package:app/buisness/action/base_action.dart';
import 'package:app/buisness/states/exercise_state.dart';
import 'package:app/data/repositories/exercise_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseBloc extends Bloc<BaseAction, ExerciseState> {
  final ExerciseRepository _exerciseRepository = ExerciseRepository();

  ExerciseBloc() : super(const ExerciseState.empty()) {}
}
