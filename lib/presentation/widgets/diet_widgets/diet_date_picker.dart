import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DietDatePicker extends StatefulWidget {
  final Function(DateTime) onDateChanged;
  const DietDatePicker({
    super.key,
    required this.onDateChanged,
  });

  @override
  State<DietDatePicker> createState() => _DietDatePickerState();
}

class _DietDatePickerState extends State<DietDatePicker> {
  dynamic selectedDate = DateFormat.yMMMMd('pl_PL').format(DateTime.now());
  final DatePickerController _controller = DatePickerController();
  @override
  Widget build(BuildContext context) {
    selectedDate == DateFormat.yMMMMd('pl_PL').format(DateTime.now())
        ? jumpToToday()
        : null;
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
              selectedDate!,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          DatePicker(
            DateTime(2024, 1, 1),
            controller: _controller,
            height: 100,
            width: 72,
            initialSelectedDate: DateTime.now(),
            selectionColor: Theme.of(context).colorScheme.primary,
            dayTextStyle: TextStyle(color: Colors.grey[200]),
            monthTextStyle: TextStyle(color: Colors.grey[200]),
            dateTextStyle: TextStyle(color: Colors.grey[200]),
            locale: 'pl_PL',
            onDateChange: (date) {
              setState(() {
                selectedDate =
                    DateFormat.yMMMMd('pl_PL').format(date).toString();
              });
              widget.onDateChanged(date);
              // // New date selecte
            },
          ),
        ],
      ),
    );
  }

  // WARNING - This method can still be improved
  Future<void> jumpToToday() async {
    await Future.delayed(const Duration(milliseconds: 200), () {
      _controller.jumpToSelection();
    });
  }
}
