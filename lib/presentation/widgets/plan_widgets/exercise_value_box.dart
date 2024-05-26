import 'package:flutter/material.dart';

class ExerciseValueBox extends StatelessWidget {
  final int value;
  final bool isWeight;
  const ExerciseValueBox({
    super.key,
    required this.value,
    this.isWeight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(
        child: Text(
          isWeight ? '$value kg' : '$value x',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
