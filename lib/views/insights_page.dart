import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:income_tally/widgets/pie_chart.dart';

import '../widgets/rounded_container.dart';

class InsidesPage extends StatefulWidget {
  const InsidesPage({super.key});

  @override
  State<StatefulWidget> createState() => InsidesPageState();
}

class InsidesPageState extends State<InsidesPage> {
  int pieChartTouchedIndex = -1;
  int graphCount = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: ListView(physics: const BouncingScrollPhysics(), children: [
          Wrap(
            children: [
              RoundedContainer(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height / graphCount,
                constraints:
                    const BoxConstraints(minHeight: 500, minWidth: 1300),
                margin: const EdgeInsets.only(
                    left: 20, top: 10, right: 20, bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomPieChart(
                        dataSet: [
                          PieChartDataEntity(
                              value: 25,
                              color: const Color(0xffc6a3ea),
                              title: '25%',
                              legendHeader: 'Housing'),
                          PieChartDataEntity(
                              value: 30,
                              color: const Color(0xffe3d4ef),
                              title: '30%',
                              legendHeader: 'Food'),
                          PieChartDataEntity(
                              value: 15,
                              color: const Color(0xff9d49e4),
                              title: '15%',
                              legendHeader: 'Transportation'),
                          PieChartDataEntity(
                              value: 30,
                              color: const Color(0xffba82e4),
                              title: '30%',
                              legendHeader: 'Health'),
                          PieChartDataEntity(
                              value: 30,
                              color: const Color(0xffba82e4),
                              title: '30%',
                              legendHeader: 'Health'),
                          PieChartDataEntity(
                              value: 30,
                              color: const Color(0xffba82e4),
                              title: '30%',
                              legendHeader: 'Health'),
                          PieChartDataEntity(
                              value: 30,
                              color: const Color(0xffba82e4),
                              title: '30%',
                              legendHeader: 'Health'),
                          PieChartDataEntity(
                              value: 30,
                              color: const Color(0xffba82e4),
                              title: '30%',
                              legendHeader: 'Health'),
                        ],
                        //centerSpaceRadius: 1,
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
              RoundedContainer(
                height: MediaQuery.of(context).size.height / graphCount,
                constraints: const BoxConstraints(minHeight: 300),
                margin: const EdgeInsets.only(
                    left: 20, top: 10, right: 20, bottom: 20),
              ),
            ],
          ),
        ]));
  }
}
