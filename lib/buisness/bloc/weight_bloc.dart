import 'package:app/buisness/action/base_action.dart';
import 'package:app/buisness/action/weight_action.dart';
import 'package:app/buisness/states/weight_state.dart';
import 'package:app/database/dao/weight_dao.dart';
import 'package:app/models/weight/weight_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeightBloc extends Bloc<BaseAction, WeightState> {
  final WeightDAO _weightDAO = WeightDAO();

  WeightBloc()
      : super(
          const WeightState.empty(),
        ) {
    on<WeightSetAction>((event, emit) async {
      // emit(const WeightState.loading());

      await _weightDAO.insertWeight(
        weight: WeightModel(
          weight: event.weight,
          date: event.date,
        ),
      );
      emit(
        WeightState(
          isLoading: false,
          data: [
            {event.weight, event.date},
          ],
          error: null,
          currentWeightPickerValue: event.weight,
        ),
      );
    });
    on<WeightGetAction>((event, emit) async {
      emit(const WeightState.loading());
      List<WeightModel> weightList = await _weightDAO.getAllWeights();
      if (weightList.isEmpty) {
        emit(const WeightState.empty());
      }
      emit(
        WeightState(
          isLoading: false,
          data: weightList,
          error: null,
          currentWeightPickerValue: weightList[weightList.length - 1].weight,
        ),
      );
    });
  }
}
