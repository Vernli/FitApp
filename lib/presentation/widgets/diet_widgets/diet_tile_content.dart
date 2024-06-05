import 'package:app/data/models/diet/meal_nutrient_model.dart';
import 'package:flutter/material.dart';

class DietTileContent extends StatefulWidget {
  final String name;
  final List<MealNutrientModel> nutirents;

  const DietTileContent({
    super.key,
    required this.name,
    required this.nutirents,
  });

  @override
  State<DietTileContent> createState() => _DietTileContentState();
}

class _DietTileContentState extends State<DietTileContent> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.name),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${widget.nutirents[0].kcal} kcal'),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Białka: ${widget.nutirents[0].proteins}g'),
          Text('Węglowodany: ${widget.nutirents[0].carbs}g'),
          Text('Tłuszcze: ${widget.nutirents[0].fat}g'),
        ],
      ),
    );
  }
}
