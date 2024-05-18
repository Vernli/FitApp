import 'package:app/buisness/bloc/weight_bloc.dart';
import 'package:app/presentation/widgets/weight_widgets/chart_card.dart';
import 'package:app/presentation/widgets/weight_widgets/weight_add_card.dart';
import 'package:flutter/material.dart';

/// A screen that displays a chart card and a weight add card.
class WeightScreen<T extends WeightBloc> extends StatelessWidget {
  const WeightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const ChartCard(),
        WeightAddCard(),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
      ],
    );
  }
}
