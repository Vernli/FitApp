import 'package:flutter/material.dart';

class PickerContoller extends ChangeNotifier {
  dynamic pickerValue;
  PickerContoller({required this.pickerValue});

  setPickerValue(double value) {
    pickerValue = value;
    notifyListeners();
  }
}
