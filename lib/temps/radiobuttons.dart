import 'package:app/presentation/widgets/components/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BtnRadioTest extends StatefulWidget {
  const BtnRadioTest({super.key});

  @override
  State<BtnRadioTest> createState() => _BtnRadioTestState();
}

class _BtnRadioTestState extends State<BtnRadioTest> {
  @override
  Widget build(BuildContext context) {
    return CustomButton(
        text: '1',
        color: Colors.grey,
        size: Size(20, 20),
        onPressed: () {},
        onPressedColor: Colors.red);
  }
}
