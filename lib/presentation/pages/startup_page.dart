import 'package:app/presentation/widgets/components/circle_button.dart';
import 'package:flutter/material.dart';

class StartupPage extends StatelessWidget {
  final Function onPressed;
  final String labelTitle;
  const StartupPage({
    super.key,
    required this.onPressed,
    required this.labelTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleButton(
          size: 140,
          onPressed: () {
            onPressed();
          },
        ),
        const SizedBox(height: 10),
        Text(
          labelTitle,
          style: const TextStyle(
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
