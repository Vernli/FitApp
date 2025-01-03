import 'package:flutter/material.dart';

class RepetitionsWeightBox extends StatelessWidget {
  final List<dynamic>? repetitions;
  final List<dynamic>? weights;
  const RepetitionsWeightBox({
    super.key,
    required this.repetitions,
    required this.weights,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        for (int i = 0; i < repetitions!.length; i++)
          Container(
            width: 86,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${repetitions![i]}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Text(
                    'x',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    '${weights![i]} kg',
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
