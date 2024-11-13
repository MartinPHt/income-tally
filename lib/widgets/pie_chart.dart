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
    return LayoutBuilder(builder: (context, constraints) {
      final bool isPortrait = constraints.maxWidth < constraints.maxHeight;
      final EdgeInsets internalChartMargin = isPortrait
          ? const EdgeInsets.only(bottom: 10)
          : const EdgeInsets.only(right: 30, top: 20, bottom: 20);
      double legendMarkerSize = 20;
      double selectedLegendMarkerSize = 24;
      double legendMarkerBottomDistance = 10;
      double selectedLegendMarkerBottomDistance = 6;
      double legendTitleFontSize = 20;
      if (constraints.maxHeight < 500) {
        legendTitleFontSize = 14;
        legendMarkerSize = 18;
        selectedLegendMarkerSize = 20;
        legendMarkerBottomDistance = 12;
        selectedLegendMarkerBottomDistance = 10;
      }

      List<Widget> widgetTree = [
        Expanded(
          child: Container(
            margin: internalChartMargin,
            child: PieChart(
              widget.dataSet.isNotEmpty
                  ? PieChartData(
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
                      sectionsSpace: 0,
                      sections: showingSections(),
                    )
                  : PieChartData(
                      sections: [
                        PieChartSectionData(
                            showTitle: true,
                            color: Colors.grey[400],
                            value: 1,
                            title: '0%',
                            //radius: radius,
                            titleStyle: TextStyle(
                              fontSize: legendTitleFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              //shadows: shadows
                            ))
                      ],
                      sectionsSpace: 0,
                    ),
            ),
          ),
        ),
        IntrinsicHeight(
          child: IntrinsicWidth(
            child: Container(
              margin: const EdgeInsets.only(
                  left: 15, top: 15, right: 15, bottom: 0),
              child: Column(
                children: List.generate(widget.dataSet.length, (i) {
                  var dataEntity = widget.dataSet[i];
                  bool isSelected = i == pieChartTouchedIndex;
                  return Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: dataEntity.color),
                            width: isSelected
                                ? selectedLegendMarkerSize
                                : legendMarkerSize,
                            height: isSelected
                                ? selectedLegendMarkerSize
                                : legendMarkerSize,
                          ),
                          SizedBox(
                            width: isSelected
                                ? selectedLegendMarkerBottomDistance
                                : legendMarkerBottomDistance,
                          ),
                          Expanded(
                              child: Text(
                            dataEntity.legendHeader,
                            style: TextStyle(
                                fontSize: legendTitleFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      )
                    ],
                  );
                }),
              ),
            ),
          ),
        )
      ];

      return isPortrait
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: widgetTree,
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: widgetTree,
            );
    });
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.dataSet.length, (i) {
      final isTouched = i == pieChartTouchedIndex;
      final fontSize = isTouched ? 20.0 : 14.0;
      //const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      var dataEntity = widget.dataSet[i];
      return PieChartSectionData(
          showTitle: true,
          color: dataEntity.color,
          value: dataEntity.value,
          title: dataEntity.title,
          //radius: radius,
          titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            //shadows: shadows
          ));
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
