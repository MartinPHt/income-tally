import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:income_tally/Models/expense_model.dart';
import 'package:income_tally/services/data_controller.dart';
import 'package:income_tally/services/helpers.dart';
import 'package:income_tally/widgets/rounded_container.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../widgets/line_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool areChartBotTitlesShortened = false;
  bool _isLoading = false;

  Future<void> _fetchExpenses() async {
    //show loading circle
    setState(() {
      _isLoading = true;
    });

    //Todo: get from API. Remove this demo when implemented from API
    await Future.delayed(const Duration(seconds: 2));
    List<ExpenseModel> retrievedExpenses = generateTestExpenses();
    DataController.instance.loadedExpensesInHomeScreen
        .addAll(retrievedExpenses);

    //hide loading circle
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // _fetchExpenses();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !_isLoading) {
        _fetchExpenses();
      }
    });
  }

  @override
  void dispose() {
    //_scrollController.dispose();
    //_sheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isBottomExpenseListVisible = true;
    bool isRightExpenseListVisible = false;
    EdgeInsets chartMargin = const EdgeInsets.all(10);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (screenWidth < 800) {
      areChartBotTitlesShortened = true;
    } else {
      areChartBotTitlesShortened = false;
      chartMargin = const EdgeInsets.all(20);
    }

    if (screenWidth > 1200) {
      isBottomExpenseListVisible = false;
      isRightExpenseListVisible = true;
    }

    if (screenHeight < 550) {
      isBottomExpenseListVisible = false;
      isRightExpenseListVisible = false;
    }

    Widget homePageBody = Stack(children: [
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
                                                "Available money",
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
                                child: ValueListenableBuilder(
                                  valueListenable: DataController
                                      .instance.avgExpensesPerMonthNotifier,
                                  builder: (context, value, child) {
                                    List<FlSpot> dataSet = [];
                                    if (value.isNotEmpty) {
                                      dataSet = value.entries.map((entry) {
                                        return FlSpot(entry.key, entry.value);
                                      }).toList();
                                    }

                                    return CustomLineChart(
                                      margin: chartMargin,
                                      bottomTitlesGenerator:
                                          lineChartBottomTitles,
                                      data: dataSet,
                                    );
                                  },
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
    ]);

    if (isBottomExpenseListVisible) {
      homePageBody = LayoutBuilder(builder: (context, constraints) {
        return SlidingUpPanel(
            maxHeight: constraints.maxHeight,
            collapsed: const CircleAvatar(
              child: Icon(Icons.account_balance),
            ),
            panelBuilder: (controller) {
              return ListView.builder(
                controller: controller,
                itemCount: 25,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.account_balance),
                    ),
                    title: Text('Item $index'),
                  );
                },
              );
            },
            body: homePageBody);
      });
    }

    return homePageBody;
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

  List<ExpenseModel> generateTestExpenses() {
    return [
      ExpenseModel(
          title: 'Car Payment',
          total: 90,
          category: ExpenseCategory.Other,
          isRecurring: false,
          time: DateTime(2024, 11)),
      ExpenseModel(
          title: 'House Insurance',
          total: 30,
          category: ExpenseCategory.Housing,
          isRecurring: true,
          time: DateTime(2024, 11)),
      ExpenseModel(
          title: 'Soft Uni',
          total: 120,
          category: ExpenseCategory.Education,
          isRecurring: false,
          time: DateTime(2024, 11)),
      ExpenseModel(
          title: 'Andrews suit',
          total: 200,
          category: ExpenseCategory.Clothing,
          isRecurring: false,
          time: DateTime(2024, 11)),
      ExpenseModel(
          title: 'Car Payment',
          total: 120,
          category: ExpenseCategory.Other,
          isRecurring: false,
          time: DateTime(2024, 10)),
      ExpenseModel(
          title: 'Medicine',
          total: 250,
          category: ExpenseCategory.Health,
          isRecurring: false,
          time: DateTime(2024, 10)),
      ExpenseModel(
          title: 'Housing',
          total: 750,
          category: ExpenseCategory.Housing,
          isRecurring: false,
          time: DateTime(2024, 9)),
      ExpenseModel(
          title: 'Housing',
          total: 150,
          category: ExpenseCategory.Housing,
          isRecurring: false,
          time: DateTime(2024, 8)),
      ExpenseModel(
          title: 'Housing',
          total: 230,
          category: ExpenseCategory.Housing,
          isRecurring: false,
          time: DateTime(2024, 7)),
      ExpenseModel(
          title: 'Car Payment',
          total: 90,
          category: ExpenseCategory.Other,
          isRecurring: false,
          time: DateTime(2024, 11)),
      ExpenseModel(
          title: 'House Insurance',
          total: 30,
          category: ExpenseCategory.Housing,
          isRecurring: true,
          time: DateTime(2024, 11)),
      ExpenseModel(
          title: 'Soft Uni',
          total: 120,
          category: ExpenseCategory.Education,
          isRecurring: false,
          time: DateTime(2024, 11)),
      ExpenseModel(
          title: 'Andrews suit',
          total: 200,
          category: ExpenseCategory.Clothing,
          isRecurring: false,
          time: DateTime(2024, 11)),
      ExpenseModel(
          title: 'Car Payment',
          total: 120,
          category: ExpenseCategory.Other,
          isRecurring: false,
          time: DateTime(2024, 10)),
      ExpenseModel(
          title: 'Medicine',
          total: 250,
          category: ExpenseCategory.Health,
          isRecurring: false,
          time: DateTime(2024, 10)),
      ExpenseModel(
          title: 'Housing',
          total: 750,
          category: ExpenseCategory.Housing,
          isRecurring: false,
          time: DateTime(2024, 9)),
      ExpenseModel(
          title: 'Housing',
          total: 150,
          category: ExpenseCategory.Housing,
          isRecurring: false,
          time: DateTime(2024, 8)),
      ExpenseModel(
          title: 'Housing',
          total: 230,
          category: ExpenseCategory.Housing,
          isRecurring: false,
          time: DateTime(2024, 7)),
    ];
  }
}
