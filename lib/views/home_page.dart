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

  @override
  Widget build(BuildContext context) {
    bool isBottomExpenseListVisible = true;
    bool isRightExpenseListVisible = false;

    if (MediaQuery.of(context).size.width > 1200) {
      isBottomExpenseListVisible = false;
      isRightExpenseListVisible = true;
    }

    return Stack(children: [
      Container(
        constraints: const BoxConstraints(maxHeight: 1200),
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
                                left: 25, top: 25, right: 15, bottom: 25),
                            constraints: const BoxConstraints(
                                minWidth: 250, maxWidth: 365),
                            borderThickness: 0.01,
                            gradient: const LinearGradient(colors: [
                              AppColors.backgroundPurple,
                              AppColors.backgroundBlue,
                            ]),
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
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
                                left: 15, top: 25, right: 25, bottom: 25),
                            constraints: const BoxConstraints(
                                minWidth: 250, maxWidth: 365),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/add_expense");
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
                  const Expanded(
                    flex: 8,
                    child: Row(
                      children: [
                        Expanded(
                          child: RoundedContainer(
                              margin: EdgeInsets.only(
                                  left: 25, top: 10, right: 25, bottom: 70),
                              padding: EdgeInsets.all(10),
                              constraints: BoxConstraints(maxWidth: 730),
                              alignment: Alignment.topLeft,
                              child: CustomLineChart(
                                data: [
                                  FlSpot(0, 3),
                                  FlSpot(2.6, 2),
                                  FlSpot(4.9, 5),
                                  FlSpot(6.8, 3.1),
                                  FlSpot(8, 4),
                                  FlSpot(9.5, 3),
                                  FlSpot(11, 4),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: isBottomExpenseListVisible,
                      child: Expanded(flex: 1, child: Container()))
                ],
              ),
            ),
            Visibility(
              visible: isRightExpenseListVisible,
              child: Expanded(
                flex: 1,
                child: RoundedContainer(
                  margin: const EdgeInsets.only(
                      left: 10, top: 25, right: 25, bottom: 70),
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
}
