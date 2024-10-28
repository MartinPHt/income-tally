import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MonthlyExpenseBarChart extends StatelessWidget {
  final List<double> expenses = [300, 500, 400, 700, 200, 500, 800, 600, 450, 350, 650, 550];

  MonthlyExpenseBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: _createBarGroups(),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 100,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString());
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                return Text(months[value.toInt()]);
              },
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _createBarGroups() {
    return List.generate(expenses.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(toY: expenses[index], color: Colors.blueAccent),
        ],
      );
    });
  }
}