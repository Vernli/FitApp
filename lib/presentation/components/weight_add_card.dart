import 'package:app/buisness/action/weight_action.dart';
import 'package:app/buisness/bloc/weight_bloc.dart';
import 'package:app/presentation/components/weight_picker.dart';
import 'package:app/presentation/components/widgets/add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeightAddCard extends StatelessWidget {
  const WeightAddCard({
    super.key,
  });

  @override
  // TODO BLOCK: implement build
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      height: MediaQuery.of(context).size.height / 4,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(1), blurRadius: 2),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const WeightPicker(),
          AddButton(
            onPressed: () {
              context.read<WeightBloc>().add(
                    WeightSetAction(
                      weight: 57.3,
                      date: DateTime.now().toString(),
                    ),
                  );
              context.read<WeightBloc>().add(
                    const WeightGetAction(),
                  );
            },
          ),
        ],
      ),
    );
  }
}
