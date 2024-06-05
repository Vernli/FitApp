import 'package:app/config/theme/app_theme.dart';
import 'package:flutter/widgets.dart';

class TileInformations extends StatelessWidget {
  final double kcal;
  final double proteins;
  final double carbs;
  final double fat;
  const TileInformations({
    super.key,
    required this.kcal,
    required this.proteins,
    required this.carbs,
    required this.fat,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '$kcal kcal',
            style: dietTileSummary,
          ),
          Text(
            'B: ${proteins}g',
            style: dietTileSummary,
          ),
          Text(
            'T: ${fat}g',
            style: dietTileSummary,
          ),
          Text(
            'W: ${carbs}g',
            style: dietTileSummary,
          ),
        ],
      ),
    );
  }
}
