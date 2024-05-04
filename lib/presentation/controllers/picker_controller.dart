import 'package:flutter/material.dart';

class PickerContoller extends ChangeNotifier {
  double pickerValue;
  PickerContoller({required this.pickerValue});

  setPickerValue(double value) {
    pickerValue = value;
    notifyListeners();
  }
}
