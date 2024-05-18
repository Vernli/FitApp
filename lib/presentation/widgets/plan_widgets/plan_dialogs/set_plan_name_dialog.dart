import 'package:app/presentation/pages/add_plan_page.dart';
import 'package:app/presentation/widgets/plan_widgets/plan_dialogs/custom_text_dialog.dart';
import 'package:flutter/material.dart';

class SetPlanNameDialog extends StatefulWidget {
  const SetPlanNameDialog({super.key});

  @override
  State<SetPlanNameDialog> createState() => _SetPlanNameDialogState();
}

class _SetPlanNameDialogState extends State<SetPlanNameDialog> {
  final TextEditingController _textController = TextEditingController();
  bool isTextEmpty = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextDialog(
      title: 'Wprowadź nazwę planu',
      hintText: 'Nazwa planu',
      errorMessage: 'Nazwa planu nie może być pusta!',
      onPressed: (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddPlanPage(
              planName: value,
            ),
          ),
        );
      },
    );
  }
}
