import 'package:app/buisness/action/weight_action.dart';
import 'package:app/buisness/bloc/weight_bloc.dart';
import 'package:app/buisness/states/weight_state.dart';
import 'package:app/extension/start_with.dart';
import 'package:app/presentation/components/weight_add_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeightScreen<T extends WeightBloc> extends StatelessWidget {
  const WeightScreen({super.key});

  void startUpdatingBloc(BuildContext context) {
    Stream.periodic(
      const Duration(seconds: 2),
      (_) => const WeightGetAction(),
    ).startWith(const WeightGetAction()).forEach((event) {
      context.read<T>().add(
            event,
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    // startUpdatingBloc(context);
    return BlocBuilder<T, WeightState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const WeightAddCard();
      },
    );
  }
}
