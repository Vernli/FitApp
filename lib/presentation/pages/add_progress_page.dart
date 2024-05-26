import 'package:app/presentation/widgets/components/controllers/picker_controller.dart';
import 'package:app/presentation/widgets/components/custom_card.dart';
import 'package:app/presentation/widgets/plan_widgets/plan_appbar.dart';
import 'package:app/presentation/widgets/plan_widgets/add_repetitions_picker.dart';
import 'package:app/presentation/widgets/plan_widgets/add_weight_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddProgressPage extends StatefulWidget {
  final String exerciseName;
  const AddProgressPage({super.key, required this.exerciseName});

  @override
  State<AddProgressPage> createState() => _AddProgressPageState();
}

class _AddProgressPageState extends State<AddProgressPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> safeAreaPadding = {
      'paddingTop': MediaQuery.of(context).padding.top,
      'paddingBottom': MediaQuery.of(context).padding.bottom,
    };
    // Calculate the free area for the content of the page
    double safeAreaHeight = MediaQuery.of(context).size.height -
        safeAreaPadding['paddingTop']! -
        safeAreaPadding['paddingBottom']! -
        106;

    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Theme.of(context).colorScheme.secondary,
        child: Column(
          children: [
            PlanAddAppbar(
              title: widget.exerciseName,
              paddingTop: safeAreaPadding['paddingTop']!,
            ),
            SizedBox(
              height: safeAreaHeight * 0.05,
            ),
            CustomCard(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AddRepetitionsPicker(
                    contoller: PickerContoller(pickerValue: 1),
                    title: 'Powtórzenia',
                  ),
                  AddWeightPicker(
                    title: 'Waga',
                    contoller: PickerContoller(pickerValue: 1.0),
                  ),
                  SizedBox(
                    height: 28,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Dodaj',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Seria ${index + 1}'),
                  );
                },
              ),
            ),
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                child: const Text(
                  'Zapisz',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Container(
              height: safeAreaPadding['paddingBottom']!,
            ),
          ],
        ),
      ),
    );
  }
}
