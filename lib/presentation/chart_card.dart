import 'package:app/presentation/components/weight_chart.dart';
import 'package:app/presentation/components/widgets/custom_button.dart';
import 'package:app/presentation/components/widgets/triangle_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChartCard extends StatelessWidget {
  const ChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.8),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: Colors.black,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(1), blurRadius: 4),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: 1000,
            height: 200,
            child: const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Chart(),
            ),
          ),
          ClipPath(
            clipper: TrianglePointer(),
            child: Container(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              width: 36,
              height: 20,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              border: const BorderDirectional(
                top: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 1,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  '2024-01-05',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                const Text(
                  '56,5kg',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomButton(
                  onPressed: () {},
                  text: 'Usuń',
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                  size: const Size(14, 32),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
