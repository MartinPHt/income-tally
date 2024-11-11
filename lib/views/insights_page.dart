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
                padding: const EdgeInsets.all(30),
                height: MediaQuery.of(context).size.height / graphCount,
                constraints: const BoxConstraints(minHeight: 300, minWidth: 1300),
                margin:
                const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomPieChart(
                        dataSet: [
                          PieChartDataEntity(value: 30, color: Colors.red, title: '30%', legendHeader: 'House'),
                          PieChartDataEntity(value: 20, color: Colors.yellow, title: '20%', legendHeader: 'Car'),
                          PieChartDataEntity(value: 30, color: Colors.blue, title: '30%', legendHeader: 'Education'),
                          PieChartDataEntity(value: 10, color: Colors.green, title: '10%', legendHeader: 'Entertainment'),
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
