import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DietDatePicker extends StatefulWidget {
  final ValueChanged<DateTime> onDateChanged;
  final DateTime initialDate;

  DietDatePicker({
    Key? key,
    required this.onDateChanged,
    DateTime? initialDate,
  })  : initialDate = initialDate ?? DateTime.now(),
        super(key: key);
  @override
  State<DietDatePicker> createState() => _DietDatePickerState();
}

class _DietDatePickerState extends State<DietDatePicker> {
  late DatePickerController _controller;
  late DateTime _selectedDate;
  @override
  void initState() {
    super.initState();

    // 1) Inicjalizujemy controllera i stan z initialDate
    _controller = DatePickerController();
    _selectedDate = widget.initialDate;

    // 2) Po pierwszym renderze wywołujemy jumpToSelection raz
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.jumpToSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    final String selectedDateText =
        DateFormat.yMMMMd('pl_PL').format(_selectedDate);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // nagłówek z wybraną datą
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              selectedDateText,
              style: const TextStyle(color: Colors.white),
            ),
          ),

          // sam DatePicker
          DatePicker(
            DateTime(2025, 1, 1), // zakres od
            controller: _controller, // nasz controller
            height: 100,
            width: 72,
            initialSelectedDate: _selectedDate, // ustawiamy initialDate
            selectionColor: Theme.of(context).colorScheme.primary,
            dayTextStyle: TextStyle(color: Colors.grey[200]),
            monthTextStyle: TextStyle(color: Colors.grey[200]),
            dateTextStyle: TextStyle(color: Colors.grey[200]),
            locale: 'pl_PL',
            onDateChange: (date) {
              setState(() {
                _selectedDate = date;
              });
              widget.onDateChanged(date);
            },
          ),
        ],
      ),
    );
  }
}
