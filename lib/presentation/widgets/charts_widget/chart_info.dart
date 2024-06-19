import 'package:app/presentation/widgets/charts_widget/line_chart_info.dart';
import 'package:flutter/material.dart';

class ChartInfo extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> data; // [{date: 2024-06-16, kcal: 1088.0}]
  final bool isCaloriesChart;
  const ChartInfo({
    super.key,
    required this.title,
    required this.data,
    required this.isCaloriesChart,
  });

  @override
  State<StatefulWidget> createState() => ChartInfoState();
}

class ChartInfoState extends State<ChartInfo> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(
              height: 12,
            ),
            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 16, left: 6),
                child: widget.isCaloriesChart
                    ? LineChartInfo(widget.data)
                    : LineChartInfo.calories(widget.data),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ],
    );
  }
}
