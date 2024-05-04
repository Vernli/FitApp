import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeightChart extends StatelessWidget {
  const WeightChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Chart();
  }
}

class Chart extends StatefulWidget {
  const Chart({super.key});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 2.0,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 10,
              top: 0,
              bottom: 10,
            ),
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white10,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: const FlTitlesData(show: false),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 24,
      minY: 50,
      maxY: 60,
      lineBarsData: [
        LineChartBarData(
          // color: Theme.of(context).colorScheme.onPrimary,
          color: Colors.white,
          spots: const [
            FlSpot(0, 50.5),
            FlSpot(2, 52),
            FlSpot(4, 54),
            FlSpot(8, 53),
            FlSpot(10, 55),
            FlSpot(12, 56.5),
            FlSpot(14, 58.5),
            FlSpot(16, 56.5),
            FlSpot(20, 56.5),
            FlSpot(24, 56.5),
            FlSpot(26, 56.5),
            FlSpot(28, 56.5),
          ],
          isCurved: true,
          barWidth: 1,
          isStrokeCapRound: true,
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
}
