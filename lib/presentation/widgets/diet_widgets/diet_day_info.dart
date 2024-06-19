import 'package:app/buisness/action/diet_action.dart';
import 'package:app/buisness/bloc/diet_bloc.dart';
import 'package:app/presentation/widgets/diet_widgets/diet_goal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DietDayInfo extends StatelessWidget {
  final Map<String, double> totalScore;
  final Map<String, int>? goal;
  const DietDayInfo({
    super.key,
    required this.totalScore,
    required this.goal,
  });

  const DietDayInfo.empty({super.key, this.goal})
      : totalScore = const {'kcal': 0, 'proteins': 0, 'carbs': 0, 'fat': 0};

  @override
  Widget build(BuildContext context) {
    Map<String, double> bar = {
      'kcal': (totalScore['kcal']!.round() / goal!['kcal']! * 70).toDouble(),
      'proteins': (totalScore['proteins']!.round() / goal!['proteins']! * 70)
          .toDouble(),
      'carbs': (totalScore['carbs']!.round() / goal!['carbs']! * 70).toDouble(),
      'fat': (totalScore['fat']!.round() / goal!['fat']! * 70).toDouble(),
    };

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      width: double.maxFinite,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 70,
                height: 10,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: bar['kcal']! <= 70 ? bar['kcal'] : 70,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    Container(
                      width: bar['kcal']! > 140
                          ? 140
                          : bar['kcal']! > 70
                              ? bar['kcal']! - 70
                              : 0,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Kcal ${totalScore['kcal']!.round() <= 9999 ? totalScore['kcal']!.round() : 9999}/${goal!['kcal']}',
                style: TextStyle(fontSize: 12, color: Colors.grey[200]),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 70,
                height: 10,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: bar['proteins']! <= 70 ? bar['proteins'] : 70,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    Container(
                      width: bar['proteins']! > 140
                          ? 140
                          : bar['proteins']! > 70
                              ? bar['proteins']! - 70
                              : 0,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Białka ${totalScore['proteins']!.round() <= 999 ? totalScore['proteins']!.round() : 999}/${goal!['proteins']}',
                style: TextStyle(fontSize: 12, color: Colors.grey[200]),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 70,
                height: 10,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: bar['fat']! <= 70 ? bar['fat'] : 70,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    Container(
                      width: bar['fat']! > 140
                          ? 140
                          : bar['fat']! > 70
                              ? bar['fat']! - 70
                              : 0,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Tł. ${totalScore['fat']!.round() <= 999 ? totalScore['fat']!.round() : 999}/${goal!['fat']}',
                style: TextStyle(fontSize: 12, color: Colors.grey[200]),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 70,
                height: 10,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: bar['carbs']! <= 70 ? bar['carbs'] : 70,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    Container(
                      width: bar['carbs']! > 140
                          ? 140
                          : bar['carbs']! > 70
                              ? bar['carbs']! - 70
                              : 0,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'Węgl. ${totalScore['carbs']!.round() <= 999 ? totalScore['carbs']!.round() : 999}/${goal!['carbs']}',
                style: TextStyle(fontSize: 12, color: Colors.grey[200]),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (dialogContext) => DietGoalDialog(
                  onAdd: (kcal, carbs, proteins, fat) {
                    context.read<DietBloc>().add(
                          UpdateCaloriesGoalAction(
                            kcal: kcal,
                            carbs: carbs,
                            proteins: proteins,
                            fat: fat,
                            date:
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                          ),
                        );
                    Navigator.of(dialogContext).pop();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
    );
  }
}
