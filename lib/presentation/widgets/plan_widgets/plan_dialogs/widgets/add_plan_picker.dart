import 'package:app/presentation/widgets/components/controllers/picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class AddPlanPicker extends StatefulWidget {
  final int maxPickerValue;
  final PickerContoller contoller;
  final Function? onChanged;
  final String title;

  const AddPlanPicker({
    super.key,
    required this.contoller,
    required this.maxPickerValue,
    required this.title,
    this.onChanged,
  });

  @override
  State<AddPlanPicker> createState() => _AddPlanPickerState();
}

class _AddPlanPickerState extends State<AddPlanPicker> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.contoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (widget.contoller.pickerValue != 1) {
                    widget.contoller.pickerValue--;
                  } else {
                    widget.contoller.pickerValue = 1;
                  }
                });
              },
              child: const Icon(Icons.remove, color: Colors.white),
            ),
            SizedBox(
              width: 100,
              child: AbsorbPointer(
                child: NumberPicker(
                  axis: Axis.horizontal,
                  minValue: 1,
                  maxValue: widget.maxPickerValue + 1,
                  value: widget.contoller.pickerValue + 1,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  selectedTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  onChanged: (_) => {
                    if (widget.onChanged != null)
                      {widget.onChanged!.call(widget.contoller.pickerValue)},
                  },
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                if (widget.contoller.pickerValue <= widget.maxPickerValue) {
                  setState(() {
                    if (widget.contoller.pickerValue < widget.maxPickerValue) {
                      widget.contoller.pickerValue++;
                    } else {
                      widget.contoller.pickerValue = widget.maxPickerValue;
                    }
                  });
                }
              },
              child: Icon(
                Icons.add,
                color: widget.contoller.pickerValue == widget.maxPickerValue
                    ? Colors.transparent
                    : Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
