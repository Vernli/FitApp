import 'package:app/config/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DietTitleBar extends StatelessWidget {
  const DietTitleBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dzisiaj', style: dietTitleStyle),
              Text(
                DateFormat.yMMMMd('pl_PL').format(DateTime.now()),
                style: dietSubtitileStyle,
              ),
            ],
          ),
          SizedBox(
            width: 100,
            child: AspectRatio(
              aspectRatio: 3,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 20,
                  sections: [
                    PieChartSectionData(
                      title: 'T',
                      color: Colors.red,
                      value: 15,
                      radius: 20,
                      titleStyle: dietTitleStyle,
                    ),
                    PieChartSectionData(
                      title: 'W',
                      color: Colors.green,
                      value: 30,
                      radius: 20,
                      titleStyle: dietTitleStyle,
                    ),
                    PieChartSectionData(
                      title: 'B',
                      color: Colors.blue,
                      value: 50,
                      radius: 20,
                      titleStyle: dietTitleStyle,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
