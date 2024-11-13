import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:income_tally/services/helpers.dart';
import 'package:income_tally/widgets/rounded_container.dart';

import '../widgets/line_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  bool areChartBotTitlesShortened = false;

  @override
  Widget build(BuildContext context) {
    bool isBottomExpenseListVisible = true;
    bool isRightExpenseListVisible = false;

    if (MediaQuery.of(context).size.width < 800) {
      areChartBotTitlesShortened = true;
    } else {
      areChartBotTitlesShortened = false;
    }

    if (MediaQuery.of(context).size.width > 1200) {
      isBottomExpenseListVisible = false;
      isRightExpenseListVisible = true;
    }

    if (MediaQuery.of(context).size.height < 550) {
      isBottomExpenseListVisible = false;
      isRightExpenseListVisible = false;
    }

    return Stack(children: [
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height -
              (isBottomExpenseListVisible ? 200 : 70),
          constraints: const BoxConstraints(maxHeight: 1200, minHeight: 600),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            //First rounded container
                            RoundedContainer(
                              width: MediaQuery.of(context).size.width / 2,
                              height: double.infinity,
                              margin: const EdgeInsets.only(
                                  left: 25, top: 25, right: 15, bottom: 15),
                              constraints: const BoxConstraints(
                                  minWidth: 250, maxWidth: 365),
                              borderThickness: 0.01,
                              gradient: const LinearGradient(colors: [
                                AppColors.backgroundPurple,
                                AppColors.backgroundBlue,
                              ]),
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Positioned(
                                        top: 20,
                                        left: 10,
                                        child: Image.asset(
                                          "lib/icons/moneyIcon.png",
                                          width: 30,
                                          height: 30,
                                        )),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Available resources",
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "2500 BGN",
                                                style: TextStyle(
                                                    color: Colors.grey[900],
                                                    fontSize: 28,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            //Second rounded container
                            RoundedContainer(
                              width: MediaQuery.of(context).size.width / 2,
                              height: double.infinity,
                              margin: const EdgeInsets.only(
                                  left: 15, top: 25, right: 25, bottom: 15),
                              constraints: const BoxConstraints(
                                  minWidth: 250, maxWidth: 365),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, "/add_expense");
                                  },
                                  style: TextButton.styleFrom(
                                      overlayColor: Colors.transparent),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                          top: 20,
                                          left: 10,
                                          child: Image.asset(
                                            "lib/icons/add.png",
                                            width: 30,
                                            height: 30,
                                          )),
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Let's add new expense",
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Add new",
                                                  style: TextStyle(
                                                      color: Colors.grey[900],
                                                      fontSize: 28,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ]),
                    ),
                    Expanded(
                      flex: 8,
                      child: Row(
                        children: [
                          Expanded(
                            child: RoundedContainer(
                                margin: EdgeInsets.only(
                                    left: 25,
                                    top: 10,
                                    right: isRightExpenseListVisible ? 0 : 30,
                                    bottom: 70),
                                padding: const EdgeInsets.all(10),
                                constraints:
                                    const BoxConstraints(maxWidth: 730),
                                alignment: Alignment.topLeft,
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
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isRightExpenseListVisible,
                child: Expanded(
                  flex: 1,
                  child: RoundedContainer(
                    cornerRadius: 20,
                    margin: const EdgeInsets.only(
                        left: 30, top: 25, right: 25, bottom: 70),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Item $index'),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      Visibility(
        visible: isBottomExpenseListVisible,
        child: DraggableScrollableSheet(
          controller: sheetController,
          initialChildSize: 0.1,
          minChildSize: 0.1,
          maxChildSize: 0.990,
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 15,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // The draggable handle
                  Container(
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: 30,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('Item $index'),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ]);
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
