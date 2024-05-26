import 'package:app/presentation/widgets/components/controllers/picker_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddWeightPicker extends StatefulWidget {
  final PickerContoller contoller;
  final String title;
  final Function? onChanged;

  const AddWeightPicker({
    super.key,
    required this.title,
    required this.contoller,
    this.onChanged,
  });

  @override
  State<AddWeightPicker> createState() => _AddWeightPickerState();
}

class _AddWeightPickerState extends State<AddWeightPicker> {
  TextEditingController textController = TextEditingController(text: '1.0');
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.contoller.dispose();
    textController.dispose();
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
            IconButton(
              onPressed: () {
                setState(() {
                  if (widget.contoller.pickerValue != 0.0) {
                    widget.contoller.pickerValue -= 0.25;
                    textController.text =
                        widget.contoller.pickerValue.toString();
                  } else {
                    widget.contoller.pickerValue = 0.0;
                    textController.text =
                        widget.contoller.pickerValue.toString();
                  }
                });
              },
              icon: const Icon(Icons.remove, color: Colors.white),
            ),
            SizedBox(
              width: 74,
              child: Center(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: TextField(
                    controller: textController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9,.]')),
                    ],
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    maxLength: 6,
                    decoration: const InputDecoration(
                      counterText: '',
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    onChanged: (value) => {
                      widget.contoller.pickerValue = double.parse(value),
                    },
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.contoller.pickerValue += 0.25;
                  textController.text = widget.contoller.pickerValue.toString();
                });
              },
              icon: const Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}