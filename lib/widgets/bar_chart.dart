import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:movil/utilities/app_colors.dart';

class DetailsChart extends StatelessWidget {
  final double taken;
  final double untaken;
  final double remain;

  const DetailsChart(this.taken, this.untaken, this.remain, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: BarChart(BarChartData(
          borderData: FlBorderData(
              border: const Border(
                  top: BorderSide.none,
                  right: BorderSide.none,
                  left: BorderSide.none,
                  bottom: BorderSide(width: 1))),
          groupsSpace: 2,
          barGroups: [
            BarChartGroupData(x: taken.toInt(), barRods: [
              BarChartRodData(toY: taken, width: 20, color: AppColors.blue),
            ]),
            BarChartGroupData(x: untaken.toInt(), barRods: [
              BarChartRodData(toY: untaken, width: 20, color: AppColors.mainRed)
            ]),
            BarChartGroupData(x: remain.toInt(), barRods: [
              BarChartRodData(toY: remain, width: 20, color: AppColors.gray)
            ])
          ])),
    );
  }
}
