import 'package:app/config/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LineChartInfo extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  final bool isCaloriesChart;
  const LineChartInfo(this.data, {super.key}) : isCaloriesChart = false;

  const LineChartInfo.calories(this.data, {super.key}) : isCaloriesChart = true;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData1,
      duration: const Duration(milliseconds: 250),
    );
  }

  List<FlSpot> calculatePoints() {
    List<FlSpot> points = [];
    List<String> currentWeekDays = currentWeek();

    for (var item in data) {
      String date = item['date'];
      int day = currentWeekDays.indexOf(date);
      if (day != -1) {
        points.add(FlSpot(day.toDouble() + 1, item['value']));
      }
    }

    return points;
  }

  List<String> currentWeek() {
    dynamic today = DateFormat('EEEE').format(DateTime.now());
    int day = DateTime.now().day;
    int year = DateTime.now().year;
    int month = DateTime.now().month;
    List<String> weekDays = [];
    switch (today) {
      case 'Monday':
        weekDays = [
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day : '0$day'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 1 : '0${day + 1}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 2 : '0${day + 2}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 3 : '0${day + 3}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 4 : '0${day + 4}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 5 : '0${day + 5}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 5 : '0${day + 6}'}',
        ];
        break;
      case 'Tuesday':
        weekDays = [
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 1 : '0${day - 1}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day : '0$day'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 1 : '0${day + 1}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 1 : '0${day + 1}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 3 : '0${day + 3}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 4 : '0${day + 4}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 5 : '0${day + 5}'}',
        ];
        break;
      case 'Wednesday':
        weekDays = [
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 2 : '0${day - 2}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 1 : '0${day - 1}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day : '0$day'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 1 : '0${day + 1}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 1 : '0${day + 1}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 3 : '0${day + 3}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 4 : '0${day + 4}'}',
        ];
        break;
      case 'Thursday':
        weekDays = [
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 3 : '0${day - 3}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 2 : '0${day - 2}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 1 : '0${day - 1}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day : '0$day'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 1 : '0${day + 1}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 1 : '0${day + 1}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 3 : '0${day + 3}'}',
        ];
        break;
      case 'Friday':
        weekDays = [
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 4 : '0${day - 4}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 3 : '0${day - 3}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 2 : '0${day - 2}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 1 : '0${day - 1}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day : '0$day'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 1 : '0${day + 1}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 1 : '0${day + 1}'}',
        ];
        break;
      case 'Saturday':
        weekDays = [
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 5 : '0${day - 5}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 4 : '0${day - 4}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 3 : '0${day - 3}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 2 : '0${day - 2}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 1 : '0${day - 1}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day : '0$day'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day + 1 : '0${day + 1}'}',
        ];
        break;
      case 'Sunday':
        weekDays = [
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 6 : '0${day - 6}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 5 : '0${day - 5}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 4 : '0${day - 4}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 3 : '0${day - 3}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 2 : '0${day - 2}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day - 1 : '0${day - 1}'}',
          '$year-${month.toString().length > 1 ? month : '0$month'}-${day.toString().length > 1 ? day : '0$day'}',
        ];
        break;
      default:
        break;
    }
    return weekDays;
  }

  LineChartData get sampleData1 => LineChartData(
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 1,
        maxX: 7,
        maxY: !isCaloriesChart ? 4000 : 75,
        minY: 0,
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    if (!isCaloriesChart) {
      switch (value.toInt()) {
        case 500:
          text = '500';
          break;
        case 1000:
          text = '1000';
          break;
        case 1500:
          text = '1500';
          break;
        case 2000:
          text = '2000';
          break;
        case 2500:
          text = '2500';
          break;
        case 3000:
          text = '3000';
          break;
        case 3500:
          text = '3500';
          break;
        case 4000:
          text = '4000';
          break;
        default:
          return Container();
      }
    } else {
      switch (value.toInt()) {
        case 15:
          text = '15';
          break;
        case 30:
          text = '30';
          break;
        case 45:
          text = '45';
          break;
        case 60:
          text = '60';
          break;
        case 75:
          text = '75';
          break;
        default:
          return Container();
      }
    }

    return Text(text, style: chartSideTiles, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 24,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('Pon', style: chartSideTiles);
        break;
      case 2:
        text = Text('Wt', style: chartSideTiles);
        break;
      case 3:
        text = Text('Śr', style: chartSideTiles);
        break;
      case 4:
        text = Text('Czw', style: chartSideTiles);
        break;
      case 5:
        text = Text('Pt', style: chartSideTiles);
        break;
      case 6:
        text = Text('Sob', style: chartSideTiles);
        break;
      case 7:
        text = Text('Nie', style: chartSideTiles);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 2),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: Colors.red,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: true),
        spots: [
          ...calculatePoints(),
        ],
      );
}
