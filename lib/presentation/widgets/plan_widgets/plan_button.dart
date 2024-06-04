import 'package:flutter/material.dart';

class PlanButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const PlanButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[800],
          // backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black38,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
