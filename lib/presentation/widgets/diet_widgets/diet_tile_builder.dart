// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app/buisness/action/diet_action.dart';
import 'package:app/buisness/bloc/diet_bloc.dart';
import 'package:app/data/models/diet/meal_model.dart';
import 'package:app/presentation/widgets/diet_widgets/add_meal_dialog.dart';
import 'package:app/presentation/widgets/diet_widgets/diet_tile.dart';
import 'package:app/presentation/widgets/diet_widgets/diet_tile_content.dart';
import 'package:app/presentation/widgets/diet_widgets/tile_informations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DietTileBuilder extends StatefulWidget {
  final String date;
  final Map<String, List<MealModel>> contentData;
  final Map<String, Map<String, double>> nutrientsScoreData;
  const DietTileBuilder({
    super.key,
    required this.date,
    required this.contentData,
    required this.nutrientsScoreData,
  });

  const DietTileBuilder.empty({super.key, required this.date})
      : contentData = const {},
        nutrientsScoreData = const {};

  @override
  State<DietTileBuilder> createState() => _DietTileBuilderState();
}

class _DietTileBuilderState extends State<DietTileBuilder> {
  int selectedTile = -1;
  final List<String> _mealNames = [
    'Śniadanie',
    'Drugie śniadanie',
    'Obiad',
    'Podwieczorek',
    'Kolacja',
    'Przekąska'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: MediaQuery.of(context).size.height * 0.55,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListView.builder(
              key: Key(selectedTile.toString()),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _mealNames.length,
              itemBuilder: (context, index) {
                return DietTile(
                  onAddButton: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => AddMealDialog(
                        date: widget.date,
                        mealType: _mealNames[index],
                        onAdd: (Map<String, dynamic> values) {
                          context.read<DietBloc>().add(
                                AddMealAction(
                                  date: widget.date,
                                  mealName: values['mealName'],
                                  mealType: _mealNames[index],
                                  kcal: double.parse(values['kcal']),
                                  carbs: double.parse(values['proteins']),
                                  proteins: double.parse(values['carbs']),
                                  fat: double.parse(values['fat']),
                                ),
                              );
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                  mealName: _mealNames[index],
                  tileInformations: TileInformations(
                    kcal: widget.nutrientsScoreData[_mealNames[index]]
                            ?['kcal'] ??
                        0,
                    proteins: widget.nutrientsScoreData[_mealNames[index]]
                            ?['proteins'] ??
                        0,
                    carbs: widget.nutrientsScoreData[_mealNames[index]]
                            ?['carbs'] ??
                        0,
                    fat: widget.nutrientsScoreData[_mealNames[index]]?['fat'] ??
                        0,
                  ),
                  initiallyExpanded: selectedTile == index,
                  onExpansionChanged: (newState) {
                    if (newState!) {
                      setState(() {
                        selectedTile = index;
                      });
                    } else {
                      setState(() {
                        selectedTile = -1;
                      });
                    }
                  },
                  children: [
                    if (widget.contentData.containsKey(_mealNames[index]))
                      for (var meal in widget.contentData[_mealNames[index]]!)
                        DietTileContent(
                          name: meal.mealName,
                          nutirents: meal.nutrients,
                        ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
