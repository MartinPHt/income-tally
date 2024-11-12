import 'package:flutter/cupertino.dart';

class DataController {
  final ValueNotifier<Map<String, double>> eachTpeExpensesNotifier =
      ValueNotifier({});
  final ValueNotifier<Map<String, double>> avgMonthlyExpensesNotifier =
      ValueNotifier({});

  static final DataController instance = DataController._internal();

  factory DataController() {
    return instance;
  }

  DataController._internal() {
    //TODO: Initialize connection to the database

    //UpdateNotifiers
  }
}
