import 'package:app/buisness/action/diet_action.dart';
import 'package:app/buisness/bloc/diet_bloc.dart';
import 'package:app/buisness/states/diet_state.dart';
import 'package:app/presentation/pages/diet_page.dart';
import 'package:app/presentation/pages/startup_page.dart';
import 'package:app/presentation/widgets/diet_widgets/diet_goal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

class DietScreen<T extends DietBloc> extends StatelessWidget {
  const DietScreen({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pl_PL', null);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: BlocBuilder<DietBloc, DietState>(
        builder: (context, state) {
          switch (state) {
            case InitDietState():
              return StartupPage(
                onPressed: () {
                  return showDialog(
                    context: context,
                    builder: (dialogContext) => DietGoalDialog(
                      onAdd: (kcal, carbs, proteins, fat) {
                        context.read<DietBloc>().add(
                              SetCaloriesGoalAction(
                                proteins: proteins,
                                carbs: carbs,
                                fat: fat,
                                kcal: kcal,
                                date: DateTime.now().toString(),
                              ),
                            );
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                  );
                },
                labelTitle: 'Ustal cel treningowy',
              );
            case LoadingDietState():
              return const CircularProgressIndicator();
            case LoadedDietState():
              return const DietPage();
          }
        },
        buildWhen: (previous, current) => previous != current,
      ),
    );
  }
}
