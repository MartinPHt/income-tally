import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../widgets/rounded_container.dart';

class InsidesPage extends StatefulWidget {
  const InsidesPage({super.key});

  final int graphCount = 5;

  @override
  State<StatefulWidget> createState() => InsidesPageState();
}

class InsidesPageState extends State<InsidesPage> {
  int pieChartTouchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: ListView(physics: const BouncingScrollPhysics(), children: [
          Container(
            height: MediaQuery.of(context).size.height / widget.graphCount,
            constraints: const BoxConstraints(minHeight: 300),
            margin:
                const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
            child: RoundedContainer(
              child: Row(
                children: [
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
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
                          borderData: FlBorderData(
                            show: false,
                          ),
                          sectionsSpace: 0,
                          centerSpaceRadius: 40,
                          sections: showingSections(),
                        ),
                      ),
                    ),
                  ),
                  // const Column(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [Text("test")],
                  // )
                ],
              ),
            ),
          ),
          Container(
              height: MediaQuery.of(context).size.height / widget.graphCount,
              constraints: const BoxConstraints(minHeight: 300),
              margin: const EdgeInsets.only(
                  left: 20, top: 10, right: 20, bottom: 20),
              child: const RoundedContainer()),
          Container(
              height: MediaQuery.of(context).size.height / widget.graphCount,
              constraints: const BoxConstraints(minHeight: 300),
              margin: const EdgeInsets.only(
                  left: 20, top: 10, right: 20, bottom: 20),
              child: const RoundedContainer()),
          Container(
              height: MediaQuery.of(context).size.height / widget.graphCount,
              constraints: const BoxConstraints(minHeight: 300),
              margin: const EdgeInsets.only(
                  left: 20, top: 10, right: 20, bottom: 20),
              child: const RoundedContainer()),
          Container(
              height: MediaQuery.of(context).size.height / widget.graphCount,
              constraints: const BoxConstraints(minHeight: 300),
              margin: const EdgeInsets.only(
                  left: 20, top: 10, right: 20, bottom: 20),
              child: const RoundedContainer()),
        ]));
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == pieChartTouchedIndex;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
              color: Colors.green,
              value: 40,
              title: '40%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: shadows));
        case 1:
          return PieChartSectionData(
              color: Colors.yellow,
              value: 20,
              title: '20%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: shadows));
        case 2:
          return PieChartSectionData(
              color: Colors.red,
              value: 30,
              title: '30%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: shadows));
        case 3:
          return PieChartSectionData(
              color: Colors.blue,
              value: 10,
              title: '10%',
              radius: radius,
              titleStyle: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: shadows));
        default:
          return PieChartSectionData();
      }
    });
  }
}
