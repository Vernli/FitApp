import 'package:app/buisness/action/weight_action.dart';
import 'package:app/buisness/bloc/weight_bloc.dart';
import 'package:app/buisness/states/weight_state.dart';
import 'package:app/presentation/components/weight_picker.dart';
import 'package:app/presentation/components/widgets/custom_button.dart';
import 'package:app/presentation/components/widgets/custom_card.dart';
import 'package:app/presentation/controllers/picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeightAddCard extends StatelessWidget {
  const WeightAddCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeightBloc, WeightState>(
      listener: (context, state) {
        // Add any necessary listener logic here
      },
      builder: (context, state) {
        final controller = PickerContoller(
          pickerValue: state.currentWeightPickerValue ?? 64.3,
        );
        return CustomCard(
          controller: controller,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              WeightPicker(
                controller: controller,
              ),
              CustomButton(
                text: 'Dodaj',
                color: Theme.of(context).colorScheme.primary,
                onPressed: () {
                  context.read<WeightBloc>().add(
                        WeightSetAction(
                          weight: controller.pickerValue,
                          date: DateTime.now().toString(),
                        ),
                      );
                },
                size: const Size(20, 40),
              ),
            ],
          ),
        );
      },
    );
  }
}
