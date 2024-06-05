import 'package:flutter/material.dart';

class DietDayInfo extends StatelessWidget {
  final Map<String, double> totalScore;
  const DietDayInfo({
    super.key,
    required this.totalScore,
  });

  const DietDayInfo.empty({super.key})
      : totalScore = const {'kcal': 0, 'proteins': 0, 'carbs': 0, 'fat': 0};

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
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
                  child: Stack(children: [
                    Container(
                      width: 60,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                    ),
                  ]),
                ),
                Text('Kcal ${totalScore['kcal']}/2600',
                    style: TextStyle(fontSize: 12, color: Colors.grey[200])),
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
                  child: Stack(children: [
                    Container(
                      width: 70,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                    ),
                  ]),
                ),
                Text('Białka ${totalScore['proteins']}/250',
                    style: TextStyle(fontSize: 12, color: Colors.grey[200])),
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
                        width: 70,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text('Tł. ${totalScore['fat']}/250',
                    style: TextStyle(fontSize: 12, color: Colors.grey[200])),
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
                        width: 100,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onBackground,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text('Węgl. ${totalScore['carbs']}/250',
                    style: TextStyle(fontSize: 12, color: Colors.grey[200])),
              ],
            ),
          ],
        ));
  }
}
