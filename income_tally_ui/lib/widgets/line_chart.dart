import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:income_tally/services/helpers.dart';
import 'package:shimmer/shimmer.dart';

class CustomLineChart extends StatefulWidget {
  final List<FlSpot> data;
  final Widget Function(double, TitleMeta) bottomTitlesGenerator;
  final EdgeInsets? margin;

  const CustomLineChart({
    super.key,
    this.data = const [],
    this.bottomTitlesGenerator = defaultGetTitle,
    this.margin,
  });

  @override
  State<CustomLineChart> createState() => _CustomLineChartState();
}

class _CustomLineChartState extends State<CustomLineChart> {
  List<Color> gradientColors = [
    AppColors.contentColorPurple,
    AppColors.contentColorBlue,
  ];

  bool showAvg = false;

  // style of the chart's background lines
  static drawChartLine() {
    return const FlLine(
      color: AppColors.mainGridLineColor,
      strokeWidth: 0.5,
    );
  }

  // style of the chart's border lines
  FlBorderData generateFlBorderData() {
    return FlBorderData(
      show: true,
      border: Border.all(color: Colors.grey, width: 1.2),
    );
  }

  @override
  Widget build(BuildContext context) {
    double averageValue = 0;
    if (widget.data.isNotEmpty) {
      double sumOfAllValues =
          widget.data.map((value) => value.y).reduce((a, b) => a + b);
      averageValue = sumOfAllValues / widget.data.length;
    }

    var lineChartTree = [
      Container(
        margin: const EdgeInsets.only(right: 10, bottom: 10),
        width: 50,
        height: 34,
        child: TextButton(
          onPressed: () {
            setState(() {
              showAvg = !showAvg;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              showAvg ? 'exc' : 'avg',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
      Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 5, right: 5),
          child: LineChart(
            showAvg ? avgData(averageValue) : mainData(),
          ),
        ),
      ),
    ];

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 600) {
        return Container(
          margin: widget.margin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: lineChartTree,
          ),
        );
      } else {
        return Container(
          margin: widget.margin,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: lineChartTree,
          ),
        );
      }
    });
  }

  LineChartData mainData() {
    return LineChartData(
      //Grid style (background grid)
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return drawChartLine();
        },
        getDrawingVerticalLine: (value) {
          return drawChartLine();
        },
      ),
      //Titles Data
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: widget.bottomTitlesGenerator,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            //getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: generateFlBorderData(),
      minX: 0,
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots: widget.data,
          isCurved: true,
          preventCurveOverShooting: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData(double averageValue) {
    List<double> values = widget.data.isNotEmpty
        ? widget.data.map((data) => data.x).toList()
        : [0.0];

    return LineChartData(
      //lineTouchData: const LineTouchData(enabled: true),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return drawChartLine();
        },
        getDrawingHorizontalLine: (value) {
          return drawChartLine();
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: widget.bottomTitlesGenerator,
            interval: 1,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 42,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: generateFlBorderData(),
      minX: 0,
      minY: 0,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(values.reduce(min), averageValue),
            FlSpot(values.reduce(max), averageValue),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LineChartShimmer extends StatelessWidget {
  const LineChartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title Shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 20,
            width: 150,
            color: Colors.grey[300],
            margin: const EdgeInsets.only(bottom: 16),
          ),
        ),
        // Line Chart Placeholder
        Expanded(
          child: CustomPaint(
            painter: _LineChartShimmerPainter(),
            child: Container(),
          ),
        ),
        const SizedBox(height: 16),
        // Bottom axis shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              7,
                  (index) => Container(
                height: 10,
                width: 30,
                color: Colors.grey[300],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LineChartShimmerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    final pointPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill;

    final path = Path();
    final points = [
      Offset(size.width * 0.1, size.height * 0.6),
      Offset(size.width * 0.3, size.height * 0.8),
      Offset(size.width * 0.5, size.height * 0.45),
      Offset(size.width * 0.7, size.height * 0.65),
      Offset(size.width * 0.9, size.height * 0.1),
    ];

    path.moveTo(points.first.dx, points.first.dy);

    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    // Draw shimmering line
    canvas.drawPath(path, paint);

    // Draw shimmering points
    for (var point in points) {
      canvas.drawCircle(point, 7, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
