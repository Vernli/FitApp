import 'package:app/buisness/action/base_action.dart';
import 'package:app/buisness/action/weight_action.dart';
import 'package:app/buisness/states/weight_state.dart';
import 'package:app/data/models/weight/weight_model.dart';
import 'package:app/data/repositories/weight_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeightBloc extends Bloc<BaseAction, WeightState> {
  final WeightRepository _weightRepository = WeightRepository();

  WeightBloc() : super(const WeightState.loading()) {
    on<InitEvent>((event, emit) async {
      emit(const WeightState.loading());
      List<Map<String, dynamic>> weightList =
          await _weightRepository.getAllWeights();
      if (weightList.isEmpty) {
        emit(const WeightState.empty());
      }
      emit(
        WeightState(
          isLoading: false,
          data: weightList,
          error: null,
          currentWeightPickerValue: weightList[weightList.length - 1]['weight'],
        ),
      );
    });

    on<WeightSetAction>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          currentWeightPickerValue: event.weight,
        ),
      );
      await _weightRepository.insertWeight(
        WeightModel(
          weight: event.weight,
          date: event.date,
          time: event.time,
        ),
      );
      emit(
        WeightState(
          isLoading: false,
          data: [
            [event.weight, event.date],
          ],
          error: null,
          currentWeightPickerValue: event.weight,
        ),
      );
    });

    on<WeightGetAction>((event, emit) async {
      emit(state.copyWith(isLoading: true));

      List<Map<String, dynamic>> weightList =
          await _weightRepository.getAllWeights();
      if (weightList.isEmpty) {
        emit(const WeightState.empty());
      }
      emit(
        WeightState(
          isLoading: false,
          data: weightList,
          error: null,
          currentWeightPickerValue: weightList[weightList.length - 1]['weight'],
        ),
      );
    });
  }
}
