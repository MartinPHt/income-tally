import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:income_tally/Models/expense_model.dart';
import 'package:income_tally/services/data_controller.dart';
import 'package:income_tally/widgets/line_chart.dart';
import 'package:income_tally/widgets/pie_chart.dart';

import '../widgets/rounded_container.dart';

class InsidesPage extends StatefulWidget {
  const InsidesPage({super.key});

  @override
  State<StatefulWidget> createState() => InsidesPageState();
}

class InsidesPageState extends State<InsidesPage> {
  int graphCount = 2;
  bool areChartBotTitlesRotated = false;
  TextStyle titlesStyle =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  //Used for bottom title generating
  Map<int, String> titleCategories = {};

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      titlesStyle = const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Roboto');
    } else if (screenWidth <= 1200) {
      titlesStyle =
          const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    } else {
      titlesStyle =
          const TextStyle(fontSize: 22, fontWeight: FontWeight.bold);
    }

    if (MediaQuery.of(context).size.width < 800) {
      areChartBotTitlesRotated = true;
    } else {
      areChartBotTitlesRotated = false;
    }

    return Container(
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: ListView(physics: const BouncingScrollPhysics(), children: [
          Wrap(
            children: [
              RoundedContainer(
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height / graphCount / 1.4,
                constraints:
                    const BoxConstraints(minHeight: 500, minWidth: 1300),
                margin: const EdgeInsets.only(
                    left: 20, top: 10, right: 20, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(left: 10, bottom: 20),
                        child:
                            Text('Expense Analytics', style: titlesStyle)),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable:
                            DataController.instance.expensesPerType,
                        builder: (context, value, child) {
                          List<PieChartDataEntity> dataSet = [];
                          if (value.isNotEmpty) {
                            var expensesSum = value.entries.map((entry) {
                              return entry.value;
                            }).reduce((a, b) => a + b);

                            dataSet = value.entries.map((entry) {
                              return PieChartDataEntity(
                                  title:
                                      '${(entry.value * 100 / expensesSum).toStringAsFixed(1)}%',
                                  value: entry.value,
                                  color: ExpenseCategoriesColors
                                      .collection[entry.key]!,
                                  legendHeader: entry.key.name);
                            }).toList();
                          }
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
                height: MediaQuery.of(context).size.height / graphCount / 1.3,
                constraints: const BoxConstraints(minHeight: 300),
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(
                    left: 20, top: 10, right: 20, bottom: 20),
                child: ValueListenableBuilder(
                  valueListenable:
                      DataController.instance.expensesPerType,
                  builder: (context, value, child) {
                    List<FlSpot> dataSet = [];
                    if (value.isNotEmpty) {
                      titleCategories.clear();
                      int index = -1;
                      dataSet = value.entries.map((entry) {
                        index++;
                        titleCategories[index] = entry.key.name.toString();
                        return FlSpot(index.toDouble(), entry.value);
                      }).toList();
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(left: 10, bottom: 0),
                            child: Text('Dashboard', style: titlesStyle)),
                        Expanded(
                          child: CustomLineChart(
                            margin: const EdgeInsets.all(10),
                            bottomTitlesGenerator: lineChartBottomTitles,
                            data: dataSet,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ]));
  }

  Widget lineChartBottomTitles(double value, TitleMeta meta) {
    try {
      var style =
          TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800], fontSize: 10);
      String text = titleCategories[value.toInt()]!;

      Widget title = Container(
        margin: const EdgeInsets.only(top: 5),
        child: Text(
          text,
          style: style,
        ),
      );
      if (areChartBotTitlesRotated) {
        title = Transform.rotate(
          alignment: Alignment.bottomCenter,
          angle: 30 * 3.14159 / 180,
          child: title,
        );
      }

      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: title,
      );
    } catch (identifier) {
      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: const Text(''),
      );
    }
  }
}
