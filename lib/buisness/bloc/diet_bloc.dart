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
      emit(LoadingDietState());

      dynamic goal = await _dietRepository.getCalorieGoal();
      if (goal.isEmpty) {
        emit(InitDietState());
        return;
      }

      Map<String, dynamic> data = await loadData(event);

      emit(
        LoadedDietState(
          nutrientsScore: data['nutrientsScore'],
          meals: data['meals'],
          goal: data['goal'],
        ),
      );
    });

    on<SetCaloriesGoalAction>((event, emit) async {
      emit(LoadingDietState());
      await _dietRepository.setCalorieGoal(
        proteins: event.proteins,
        carbs: event.carbs,
        fat: event.fat,
        kcal: event.kcal,
      );
      Map<String, dynamic> data = await loadData(event);

      emit(
        LoadedDietState(
          nutrientsScore: data['nutrientsScore'],
          meals: data['meals'],
          goal: data['goal'],
        ),
      );
    });

    on<AddMealAction>((event, emit) async {
      emit(LoadingDietState());
      await _dietRepository.addMeal(
        mealName: event.mealName,
        mealType: event.mealType,
        date: event.date,
        kcal: event.kcal,
        carbs: event.carbs,
        protein: event.proteins,
        fat: event.fat,
      );
      emit(LoadingDietState());

      Map<String, dynamic> data = await loadData(event);

      emit(
        LoadedDietState(
          nutrientsScore: data['nutrientsScore'],
          meals: data['meals'],
          goal: data['goal'],
        ),
      );
    });

    on<ReadMealAction>((event, emit) async {
      emit(LoadingDietState());
      Map<String, dynamic> data = await loadData(event);

      emit(
        LoadedDietState(
          nutrientsScore: data['nutrientsScore'],
          meals: data['meals'],
          goal: data['goal'],
        ),
      );
    });

    on<UpdateCaloriesGoalAction>((event, emit) async {
      emit(LoadingDietState());
      await _dietRepository.updateCalorieGoal(
        proteins: event.proteins,
        carbs: event.carbs,
        fat: event.fat,
        kcal: event.kcal,
      );
      Map<String, dynamic> data = await loadData(event);

      emit(
        LoadedDietState(
          nutrientsScore: data['nutrientsScore'],
          meals: data['meals'],
          goal: data['goal'],
        ),
      );
    });
  }

  Future<Map<String, dynamic>> loadData(event) async {
    Map<String, int> goal = await _dietRepository.getCalorieGoal();

    Map<String, Map<String, double>> nutrientsScore =
        await _dietRepository.getTotalNutrients(event.date);
    Map<String, List<MealModel>> meals =
        await _dietRepository.getAllMeals(event.date);
    return {'nutrientsScore': nutrientsScore, 'meals': meals, 'goal': goal};
  }
}
