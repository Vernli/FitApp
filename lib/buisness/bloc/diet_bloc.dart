import 'package:app/buisness/action/base_action.dart';
import 'package:app/buisness/action/diet_action.dart';
import 'package:app/buisness/states/diet_state.dart';
import 'package:app/data/models/diet/meal_model.dart';
import 'package:app/data/repositories/diet_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DietBloc extends Bloc<BaseAction, DietState> {
  final DietRepository _dietRepository = DietRepository();

  DietBloc() : super(InitDietState()) {
    on<InitDietAction>((event, emit) async {
      emit(DietLoadingState());

      Map<String, Map<String, double>> nutrientsScore =
          await _dietRepository.getTotalNutrients(event.date);

      if (nutrientsScore.isEmpty) {
        emit(InitDietState());
        return;
      }
      Map<String, List<MealModel>> meals =
          await _dietRepository.getAllMeals(event.date);
      emit(DietLoadedState(nutrientsScore: nutrientsScore, meals: meals));
    });

    on<AddMealAction>((event, emit) async {
      emit(DietLoadingState());
      await _dietRepository.addMeal(
        mealName: event.mealName,
        mealType: event.mealType,
        date: event.date,
        kcal: event.kcal,
        carbs: event.carbs,
        protein: event.proteins,
        fat: event.fat,
      );
      emit(DietLoadingState());
      Map<String, Map<String, double>> nutrientsScore =
          await _dietRepository.getTotalNutrients(event.date);
      Map<String, List<MealModel>> meals =
          await _dietRepository.getAllMeals(event.date);
      emit(DietLoadedState(nutrientsScore: nutrientsScore, meals: meals));
    });

    on<ReadMealAction>((event, emit) async {
      Map<String, Map<String, double>> nutrientsScore =
          await _dietRepository.getTotalNutrients(event.date);
      Map<String, List<MealModel>> meals =
          await _dietRepository.getAllMeals(event.date);

      emit(DietLoadedState(nutrientsScore: nutrientsScore, meals: meals));
    });
  }
}
