import 'package:flutter/cupertino.dart';
import 'package:income_tally/Models/expense_model.dart';

class DataController {
  final ValueNotifier<Map<ExpenseCategory, double>> expensesPerTypeNotifier =
      ValueNotifier({});
  final ValueNotifier<Map<String, double>> avgMonthlyExpensesNotifier =
      ValueNotifier({});

  static final DataController instance = DataController._internal();

  factory DataController() {
    return instance;
  }

  DataController._internal() {
    //TODO: Initialize connection to the database

    List<ExpenseModel> allExpenses = [
      ExpenseModel(title: 'Car Payment', total: 90, category: ExpenseCategory.Other, isRecurring: false, time: DateTime(2024, 11)),
      ExpenseModel(title: 'House Insurance', total: 30, category: ExpenseCategory.Housing, isRecurring: true, time: DateTime(2024, 11)),
      ExpenseModel(title: 'Soft Uni', total: 120, category: ExpenseCategory.Education, isRecurring: false, time: DateTime(2024, 11)),
      ExpenseModel(title: 'Andrews suit', total: 200, category: ExpenseCategory.Clothing, isRecurring: false, time: DateTime(2024, 11)),
      ExpenseModel(title: 'Car Payment', total: 120, category: ExpenseCategory.Other, isRecurring: false, time: DateTime(2024, 10)),
      ExpenseModel(title: 'Medicine', total: 250, category: ExpenseCategory.Health, isRecurring: false, time: DateTime(2024, 10)),
    ];
    var thisMonth = 11;
    var thisYear = 2024;
    List<ExpenseModel> lastMonthExpenses = allExpenses.where((expense) => expense.time.year == thisYear && expense.time.month == thisMonth).toList();

    Map<ExpenseCategory, double> expensesPerType = {};
    //calculate each type portion for the last month
    for (var expense in lastMonthExpenses) {
      var key = expense.category;
      if (expensesPerType.containsKey(key)) {
        expensesPerType[key] = expensesPerType[key]! + expense.total;
      }
      else {
        expensesPerType[key] = expense.total;
      }
    }

    expensesPerTypeNotifier.value = expensesPerType;
  }
}
