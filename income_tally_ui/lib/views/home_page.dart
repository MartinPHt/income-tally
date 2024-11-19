import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:income_tally/Models/expense_model.dart';
import 'package:income_tally/services/data_controller.dart';
import 'package:income_tally/services/helpers.dart';
import 'package:income_tally/widgets/rounded_container.dart';
import 'package:income_tally/widgets/sliding_menu_item.dart';
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
  double slidingPanelMinHeight = 130;
  PanelController panelController = PanelController();

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
    bool isSlidingUpPanelVisible = true;
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
      isSlidingUpPanelVisible = false;
      isRightExpenseListVisible = true;
    }

    if (screenHeight < 780) {
      isSlidingUpPanelVisible = false;
      isRightExpenseListVisible = false;
    }

    Widget homePageBody = Stack(children: [
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height -
              (isSlidingUpPanelVisible ? 300 : 130),
          constraints: const BoxConstraints(maxHeight: 1200, minHeight: 500),
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
                                ),
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
                    Visibility(
                        visible: !isSlidingUpPanelVisible,
                        child: const SizedBox(height: 40)),
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
                        left: 30, top: 25, right: 25, bottom: 40),
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 15),
                          child: const Text(
                            'Expenses',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...generateTestExpensesWidgets()
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ]);

    if (isSlidingUpPanelVisible) {
      homePageBody = SlidingUpPanel(
          maxHeight: screenHeight - 150,
          minHeight: slidingPanelMinHeight,
          controller: panelController,
          boxShadow: [
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 15,
              offset: const Offset(0, 3),
            ),
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          panelBuilder: (controller) {
            return Column(
              children: [
                // Drag Handle
                GestureDetector(
                  onTap: togglePanel,
                  child: Column(children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Center(
                      child: Container(
                        width: 40,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: controller,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 20, top: 5, bottom: 5),
                                child: const Text(
                                  'Expenses',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              ...generateTestExpensesWidgets()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
          body: homePageBody);
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

  void togglePanel() {
    if (panelController.isPanelOpen) {
      panelController.close();
    } else {
      panelController.open();
    }
  }

  List<Widget> generateTestExpensesWidgets() {
    return List.generate(25, (index) {
      return SlidingMenuItem(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        model: ExpenseModel(
            title: 'Softuni',
            total: 90,
            category: ExpenseCategory.Education,
            isRecurring: false,
            date: DateTime(2024, 11)),
      );
    });
  }

  List<ExpenseModel> generateTestExpenses() {
    return [
      ExpenseModel(
          title: 'Car Payment',
          total: 90,
          category: ExpenseCategory.Other,
          isRecurring: false,
          date: DateTime(2024, 11)),
      ExpenseModel(
          title: 'House Insurance',
          total: 30,
          category: ExpenseCategory.Housing,
          isRecurring: true,
          date: DateTime(2024, 11)),
      ExpenseModel(
          title: 'Soft Uni',
          total: 120,
          category: ExpenseCategory.Education,
          isRecurring: false,
          date: DateTime(2024, 11)),
      ExpenseModel(
          title: 'Andrews suit',
          total: 200,
          category: ExpenseCategory.Clothing,
          isRecurring: false,
          date: DateTime(2024, 11)),
      ExpenseModel(
          title: 'Car Payment',
          total: 120,
          category: ExpenseCategory.Other,
          isRecurring: false,
          date: DateTime(2024, 10)),
      ExpenseModel(
          title: 'Medicine',
          total: 250,
          category: ExpenseCategory.Health,
          isRecurring: false,
          date: DateTime(2024, 10)),
      ExpenseModel(
          title: 'Housing',
          total: 750,
          category: ExpenseCategory.Housing,
          isRecurring: false,
          date: DateTime(2024, 9)),
      ExpenseModel(
          title: 'Housing',
          total: 150,
          category: ExpenseCategory.Housing,
          isRecurring: false,
          date: DateTime(2024, 8)),
      ExpenseModel(
          title: 'Housing',
          total: 230,
          category: ExpenseCategory.Housing,
          isRecurring: false,
          date: DateTime(2024, 7)),
      ExpenseModel(
          title: 'Car Payment',
          total: 90,
          category: ExpenseCategory.Other,
          isRecurring: false,
          date: DateTime(2024, 11)),
      ExpenseModel(
          title: 'House Insurance',
          total: 30,
          category: ExpenseCategory.Housing,
          isRecurring: true,
          date: DateTime(2024, 11)),
      ExpenseModel(
          title: 'Soft Uni',
          total: 120,
          category: ExpenseCategory.Education,
          isRecurring: false,
          date: DateTime(2024, 11)),
      ExpenseModel(
          title: 'Andrews suit',
          total: 200,
          category: ExpenseCategory.Clothing,
          isRecurring: false,
          date: DateTime(2024, 11)),
      ExpenseModel(
          title: 'Car Payment',
          total: 120,
          category: ExpenseCategory.Other,
          isRecurring: false,
          date: DateTime(2024, 10)),
      ExpenseModel(
          title: 'Medicine',
          total: 250,
          category: ExpenseCategory.Health,
          isRecurring: false,
          date: DateTime(2024, 10)),
      ExpenseModel(
          title: 'Housing',
          total: 750,
          category: ExpenseCategory.Housing,
          isRecurring: false,
          date: DateTime(2024, 9)),
      ExpenseModel(
          title: 'Housing',
          total: 150,
          category: ExpenseCategory.Housing,
          isRecurring: false,
          date: DateTime(2024, 8)),
      ExpenseModel(
          title: 'Housing',
          total: 230,
          category: ExpenseCategory.Housing,
          isRecurring: false,
          date: DateTime(2024, 7)),
    ];
  }
}
