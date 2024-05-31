import 'package:flutter/material.dart';

class ProgressBox extends StatelessWidget {
  final double percentageProgress;
  const ProgressBox({
    super.key,
    required this.percentageProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 40,
      decoration: BoxDecoration(
        color: percentageProgress < 0
            ? const Color(0xFF5A1F1F)
            : Theme.of(context).colorScheme.primary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 2,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$percentageProgress %',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
