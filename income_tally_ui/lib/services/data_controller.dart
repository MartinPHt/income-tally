import 'package:flutter/cupertino.dart';
import 'package:income_tally/Models/expense_model.dart';

class DataController {
  final ValueNotifier<Map<ExpenseCategory, double>> expensesPerType =
      ValueNotifier({});
  final ValueNotifier<Map<double, double>> avgExpensesPerMonth =
      ValueNotifier({});
  final ValueNotifier<List<ExpenseModel>> allExpenses =
      ValueNotifier([]);

  static final DataController instance = DataController._internal();

  factory DataController() {
    return instance;
  }

  DataController._internal() {
    //TODO: Initialize connection to the database

    //retrieved info (all records)
    List<ExpenseModel> expenses = [
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

    allExpenses.value = expenses;

    DateTime dateTime = DateTime.now();
    var thisMonth = dateTime.month;
    var thisYear = dateTime.year;

    List<ExpenseModel> filteredExpenses = expenses
        .where((expense) =>
            expense.date.year == thisYear && expense.date.month == thisMonth)
        .toList();
    updateExpensesPerType(filteredExpenses);

    filteredExpenses =
        expenses.where((expense) => expense.date.year == thisYear).toList();
    updateAvgExpensesPerMonth(filteredExpenses);
  }

  void updateExpensesPerType(List<ExpenseModel> expenses) {
    Map<ExpenseCategory, double> map = {};
    for (var expense in expenses) {
      var key = expense.category;
      if (map.containsKey(key)) {
        map[key] = map[key]! + expense.total;
      } else {
        map[key] = expense.total;
      }
    }
    expensesPerType.value = map;
  }

  void updateAvgExpensesPerMonth(List<ExpenseModel> expenses) {
    Map<double, double> map = {};
    try {
      for (var expense in expenses) {
        var key = expense.date.month.toDouble();
        if (map.containsKey(key)) {
          map[key] = map[key]! + expense.total;
        } else {
          map[key] = expense.total;
        }
      }
    } catch (exception) {}
    avgExpensesPerMonth.value = map;
  }
}
