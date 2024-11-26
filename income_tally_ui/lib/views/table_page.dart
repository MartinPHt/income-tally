import 'package:flutter/material.dart';
import 'package:income_tally/services/data_controller.dart';
import 'package:income_tally/widgets/error_state_widget.dart';
import 'package:income_tally/widgets/expense_table_item.dart';
import 'package:income_tally/widgets/rounded_container.dart';
import 'package:income_tally/widgets/shimmer_loading_list.dart';
import 'package:income_tally/widgets/state_aware_widget.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<StatefulWidget> createState() => TablePageState();
}

class TablePageState extends State<TablePage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: RoundedContainer(
                    margin: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(10),
                              physics: const BouncingScrollPhysics(),
                              child: StateAwareWidget(
                                notifier: DataController.instance.allExpensesState,
                                successWidget: ValueListenableBuilder(
                                    valueListenable: DataController.instance.allExpenses,
                                    builder: (context, value, child) {
                                      return Column(
                                        children: List.generate(
                                            DataController.instance.allExpenses.value.length,
                                            (index) {
                                          return Container(
                                            margin: const EdgeInsets.symmetric(vertical: 10),
                                            child: ExpenseTableItem(
                                                model: DataController
                                                    .instance.allExpenses.value[index]),
                                          );
                                        }),
                                      );
                                    }),
                                onLoadingWidget: const ShimmerLoadingList(
                                  length: 10,
                                ),
                                onErrorWidget: Container(margin: const EdgeInsets.only(top: 100), child: const ErrorStateWidget()),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
