import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatefulWidget {
  final List<PieChartDataEntity> dataSet;
  final double? centerSpaceRadius;

  const CustomPieChart(
      {super.key, required this.dataSet, this.centerSpaceRadius});

  @override
  State<StatefulWidget> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  int pieChartTouchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          fit: FlexFit.tight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final dynamicRadius =
                  (constraints.maxWidth < constraints.maxHeight
                          ? constraints.maxWidth
                          : constraints.maxHeight) *
                      0.45;

              return PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          pieChartTouchedIndex = -1;
                          return;
                        }
                        pieChartTouchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  centerSpaceRadius: 0,
                  sectionsSpace: 0,
                  sections: showingSections(dynamicRadius),
                ),
              );
            },
          ),
        ),
        IntrinsicHeight(
          child: IntrinsicWidth(
            child: Container(
              margin: const EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 5),
              child: Column(
                children: List.generate(widget.dataSet.length, (i) {
                  var dataEntity = widget.dataSet[i];

                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: dataEntity.color),
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Text(
                            dataEntity.legendHeader,
                            style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                          ))
                        ],
                      ),
                      const SizedBox(height: 5,)
                    ],
                  );
                }),
              ),
            ),
          ),
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections(double dynamicRadius) {
    return List.generate(widget.dataSet.length, (i) {
      final isTouched = i == pieChartTouchedIndex;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? dynamicRadius + 10 : dynamicRadius;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      var dataEntity = widget.dataSet[i];
      return PieChartSectionData(
          showTitle: true,
          color: dataEntity.color,
          value: dataEntity.value,
          title: dataEntity.title,
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows));
    });
  }
}

class PieChartDataEntity {
  final double value;
  final Color color;
  final String title;
  final String legendHeader;

  PieChartDataEntity(
      {required this.value,
      required this.color,
      required this.title,
      required this.legendHeader});
}
