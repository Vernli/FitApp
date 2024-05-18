import 'package:app/buisness/action/weight_action.dart';
import 'package:app/buisness/bloc/weight_bloc.dart';
import 'package:app/buisness/states/weight_state.dart';
import 'package:app/presentation/widgets/weight_widgets/weight_picker.dart';
import 'package:app/presentation/widgets/components/custom_button.dart';
import 'package:app/presentation/widgets/components/custom_card.dart';
import 'package:app/presentation/widgets/components/controllers/picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeightAddCard extends StatelessWidget {
  WeightAddCard({
    super.key,
  });

  final PickerContoller controller = PickerContoller(
    pickerValue: 64.3,
  );

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<WeightBloc, WeightState>(
            builder: (context, state) {
              if (state.currentWeightPickerValue != null) {
                controller.pickerValue = state.currentWeightPickerValue!;
              }
              return WeightPicker(
                controller: controller,
              );
            },
          ),
          CustomButton(
            text: 'Dodaj',
            color: Theme.of(context).colorScheme.primary,
            onPressedColor: Theme.of(context).colorScheme.primaryContainer,
            onPressed: () {
              Map<String, String> date = getDate();
              context.read<WeightBloc>().add(
                    WeightSetAction(
                      weight: double.parse(
                        controller.pickerValue.toStringAsFixed(2),
                      ),
                      date: date['date']!,
                      time: date['time']!,
                    ),
                  );
            },
            size: const Size(20, 40),
          ),
        ],
      ),
    );
  }
}

Map<String, String> getDate() {
  final DateTime now = DateTime.now();
  final String formattedDate =
      '${now.year}-${now.month.toString().length == 1 ? '0${now.month}' : now.month}-${now.day}';
  final String formattedTime = '${now.hour}:${now.minute}:${now.second}';
  return {
    'date': formattedDate,
    'time': formattedTime,
  };
}
