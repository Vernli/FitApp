import 'package:flutter/material.dart';

class RepetitionsWeightBox extends StatelessWidget {
  final int repetitions;
  final int weight;
  const RepetitionsWeightBox({
    super.key,
    required this.repetitions,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border:
            Border.all(color: Theme.of(context).colorScheme.primary, width: 1),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '$repetitions x',
              style: const TextStyle(color: Colors.white),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              width: 1,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(
              '$weight kg',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
