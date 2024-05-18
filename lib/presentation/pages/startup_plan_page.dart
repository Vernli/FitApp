import 'package:app/presentation/widgets/components/circle_button.dart';
import 'package:app/presentation/widgets/plan_widgets/plan_dialogs/set_plan_name_dialog.dart';
import 'package:flutter/material.dart';

class StartupPlanPage extends StatelessWidget {
  const StartupPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleButton(
          size: 140,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const SetPlanNameDialog();
              },
            );
          },
        ),
        const SizedBox(height: 10),
        const Text(
          'Dodaj',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.10,
        ),
      ],
    );
  }
}
