import 'package:flutter/cupertino.dart';
import 'package:income_tally/Models/expense_model.dart';

class DataController {
  final ValueNotifier<Map<ExpenseCategory, double>> expensesPerTypeNotifier =
      ValueNotifier({});
  final ValueNotifier<Map<double, double>> avgExpensesPerMonthNotifier =
      ValueNotifier({});

  final List<ExpenseModel> loadedExpensesInHomeScreen = [];

  static final DataController instance = DataController._internal();

  factory DataController() {
    return instance;
  }

  DataController._internal() {
    //TODO: Initialize connection to the database

    //retrieved info (all records)
    List<ExpenseModel> allExpenses = [
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

    DateTime dateTime = DateTime.now();
    var thisMonth = dateTime.month;
    var thisYear = dateTime.year;

    List<ExpenseModel> filteredExpenses = allExpenses
        .where((expense) =>
            expense.time.year == thisYear && expense.time.month == thisMonth)
        .toList();
    updateExpensesPerTypeNotifier(filteredExpenses);

    filteredExpenses =
        allExpenses.where((expense) => expense.time.year == thisYear).toList();
    updateAvgExpensesPerMonthNotifier(filteredExpenses);
  }

  void updateExpensesPerTypeNotifier(List<ExpenseModel> expenses) {
    Map<ExpenseCategory, double> expensesPerType = {};
    for (var expense in expenses) {
      var key = expense.category;
      if (expensesPerType.containsKey(key)) {
        expensesPerType[key] = expensesPerType[key]! + expense.total;
      } else {
        expensesPerType[key] = expense.total;
      }
    }
    expensesPerTypeNotifier.value = expensesPerType;
  }

  void updateAvgExpensesPerMonthNotifier(List<ExpenseModel> expenses) {
    Map<double, double> avgExpensesPerMonth = {};
    try {
      for (var expense in expenses) {
        var key = expense.time.month.toDouble();
        if (avgExpensesPerMonth.containsKey(key)) {
          avgExpensesPerMonth[key] = avgExpensesPerMonth[key]! + expense.total;
        } else {
          avgExpensesPerMonth[key] = expense.total;
        }
      }
    }
    catch (exception) {

    }
    avgExpensesPerMonthNotifier.value = avgExpensesPerMonth;
  }
}
