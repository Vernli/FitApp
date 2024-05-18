import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// A widget that displays a line chart.
class Chart extends StatefulWidget {
  const Chart({super.key, required this.weightList});
  final List<double> weightList;
  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.0,
          child: LineChart(
            mainData(),
          ),
        ),
      ],
    );
  }

  /// Returns the data for the line chart.
  LineChartData mainData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: const FlGridData(show: false),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 20,
      minY: widget.weightList.reduce(min) - 40,
      maxY: widget.weightList.reduce(max) + 20,
      lineBarsData: [
        LineChartBarData(
          color: Colors.white,

          // Distance formula between each spot on the x-axis:
          // deltaX = xMax - xMin
          // ((x - minX) / deltaX) * canvaSize
          spots: calculateChartSpots(widget.weightList),

          isCurved: true,
          barWidth: 1,
          isStrokeCapRound: true,
          isStrokeJoinRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(
                0.4,
              ),
              Colors.white.withOpacity(0.6),
              Colors.white.withOpacity(0.8),
              Colors.white.withOpacity(1),
            ],
          ),

          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.onPrimary.withOpacity(0.9),
                Theme.of(context).colorScheme.primary.withOpacity(0.6),
                Theme.of(context).colorScheme.background.withOpacity(0.3),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  /// Calculates the chart spots based on the given value.
  List<FlSpot> calculateChartSpots(dynamic value) {
    List<FlSpot> spots = [];
    for (int i = 0; i < value.length; i++) {
      spots.add(FlSpot(i * 10, value[i] as double));
    }
    return spots;
  }
}
