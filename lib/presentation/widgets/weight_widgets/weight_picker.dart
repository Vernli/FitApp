import 'dart:ui';
import 'package:app/presentation/widgets/components/controllers/picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
                        blurRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          DecimalNumberPicker(
            integerTextMapper: (numberText) => '$numberText',
            decimalTextMapper: (numberText) => '$numberText',
            itemWidth: 64,
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
            haptics: true,
            minValue: 1,
            maxValue: 999,
            decimalPlaces: 2,
            onChanged: (value) => {
              setState(() => widget.controller.setPickerValue(value)),
            },
          ),
          const Positioned(
              right: 125,
              bottom: 61,
              child: Text(
                '.',
                style: TextStyle(color: Colors.white, fontSize: 18),
              )),

          /// A positioned widget that displays the unit 'kg' at a specific location.
          const Positioned(
            right: 38,
            bottom: 61,
            child: Text(
              'kg',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
