import 'dart:ui';
import 'package:app/presentation/controllers/picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class WeightPicker extends StatefulWidget {
  const WeightPicker({super.key, required this.controller});

  final PickerContoller controller;

  @override
  State<WeightPicker> createState() => _WeightPickerState();
}

class _WeightPickerState extends State<WeightPicker> {
  @override
  void initState() {
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 250,
      child: Stack(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.6)),
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.98),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          DecimalNumberPicker(
            integerTextMapper: (numberText) => '$numberText kg',
            decimalTextMapper: (numberText) => '. $numberText g',
            selectedTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            textStyle: const TextStyle(
              color: Color(0XAAFFFFFF),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
            value: widget.controller.pickerValue,
            minValue: 0,
            maxValue: 200,
            decimalPlaces: 2,
            onChanged: (value) => {
              setState(() => widget.controller.setPickerValue(value)),
            },
          ),
        ],
      ),
    );
  }
}


// Base Button (main styling) <- WeightButton (functions) -> onPress add
// Weight Card <- required BaeButton 
// On Press chart is loading and show new chart 
// WeightBloc -> WeightScreen

/*
|| ADD BUTTON ---> WEIGHT UPDATE ---> CHANGE CURRENT WEIGHT || 
*/