import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:income_tally/Models/expense_model.dart';
import 'package:income_tally/services/data_controller.dart';
import 'package:income_tally/services/helpers.dart';
import 'package:income_tally/widgets/line_chart.dart';
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
  bool areChartBotTitlesShortened = false;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 800) {
      areChartBotTitlesShortened = true;
    } else {
      areChartBotTitlesShortened = false;
    }

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
                      child: ValueListenableBuilder(
                        valueListenable:
                            DataController.instance.expensesPerTypeNotifier,
                        builder: (context, value, child) {
                          var expensesSum = value.entries.map((entry) {
                            return entry.value;
                          }).reduce((a, b) => a + b);

                          var dataSet = value.entries.map((entry) {
                            return PieChartDataEntity(
                                title:
                                    '${(entry.value * 100 / expensesSum).toStringAsFixed(1)}%',
                                value: entry.value,
                                color: ExpenseCategoriesColors
                                    .collection[entry.key]!,
                                legendHeader: entry.key.name);
                          }).toList();
                          return CustomPieChart(
                            dataSet: dataSet,
                            //centerSpaceRadius: 1,
                          );
                        },
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
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(
                    left: 20, top: 10, right: 20, bottom: 20),
                child: CustomLineChart(
                  bottomTitlesGenerator: lineChartBottomTitles,
                  data: const [
                    FlSpot(0, 240),
                    FlSpot(1, 590),
                    FlSpot(2, 360),
                    FlSpot(3, 120),
                    FlSpot(4, 10),
                    FlSpot(5, 700),
                    FlSpot(6, 700),
                    FlSpot(7, 400),
                    FlSpot(8, 700),
                    FlSpot(9, 234),
                    FlSpot(10, 654),
                    FlSpot(11, 32),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }

  Widget lineChartBottomTitles(double value, TitleMeta meta) {
    try {
      var style =
          TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800]);
      String title;
      if (areChartBotTitlesShortened) {
        title = ChartHelper.monthsShortened[value.toInt()];
      } else {
        title = ChartHelper.months[value.toInt()];
      }
      Widget text = Text(
        title,
        style: style,
      );

      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: text,
      );
    } catch (identifier) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: const Text(''),
      );
    }
  }
}
