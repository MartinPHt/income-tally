import 'package:flutter/cupertino.dart';
import 'package:income_tally/Models/expense_model.dart';
import 'package:income_tally/Models/request_model.dart';
import 'package:income_tally/Models/response_model.dart';
import 'package:income_tally/services/http_service.dart';

class DataController {
  //expenses per type notifiers
  final ValueNotifier<DataState> expPerTypeState =
      ValueNotifier(DataState.loading);
  final ValueNotifier<Map<ExpenseCategory, double>> expPerType =
      ValueNotifier({});

  //average expenses per month notifiers
  final ValueNotifier<DataState> monthlyExpensesState =
      ValueNotifier(DataState.loading);
  final ValueNotifier<Map<double, double>> monthlyExpenses = ValueNotifier({});

  //all expenses notifiers
  final ValueNotifier<DataState> allExpensesState =
      ValueNotifier(DataState.loading);
  final ValueNotifier<List<ExpenseModel>> allExpenses = ValueNotifier([]);

  final ValueNotifier<String?> serverError = ValueNotifier(null);

  static final DataController instance = DataController._internal();

  factory DataController() {
    return instance;
  }

  DataController._internal();

  //Data fetching methods
  Future<void> performExpensesFetch(
      {bool fetchMonthlyExpenses = false, bool fetchExpPerType = false}) async {
    try {
      //indicate that a response from the server is awaited
      allExpensesState.value = DataState.loading;
      if (fetchMonthlyExpenses) {
        monthlyExpensesState.value = DataState.loading;
      }
      if (fetchExpPerType) {
        expPerTypeState.value = DataState.loading;
      }

      //handle the response
      List<dynamic> responseList =
          await ExpenseHttpService.instance.getAllAsync<List<dynamic>>();

      //explicitly cast the response
      List<ExpenseResponse> expenseList = responseList
          .map((item) => ExpenseResponse.fromJson(item as Map<String, dynamic>))
          .toList();

      allExpenses.value = convertResponseToExpenses(expenseList);
      allExpensesState.value = DataState.success;

      //Filters. Can be passed later on
      DateTime dateTime = DateTime.now();
      var thisMonth = dateTime.month;
      var thisYear = dateTime.year;
      List<ExpenseModel> filteredExpenses;

      if (fetchMonthlyExpenses) {
        filteredExpenses = allExpenses.value
            .where((expense) =>
                expense.date.year == thisYear &&
                expense.date.month == thisMonth)
            .toList();
        updateExpensesPerType(filteredExpenses);
        expPerTypeState.value = DataState.success;
      }

      if (fetchExpPerType) {
        filteredExpenses = allExpenses.value
            .where((expense) => expense.date.year == thisYear)
            .toList();
        filteredExpenses.sort((a, b) => a.date.month.compareTo(b.date.month));
        updateAverageExpenses(filteredExpenses);
      }
    } catch (e) {
      allExpensesState.value = DataState.error;
      expPerTypeState.value = DataState.error;
      monthlyExpensesState.value = DataState.error;
    }
  }

  Future<void> performAddExpense(ExpenseModel model) async {
    await ExpenseHttpService.instance.postAsync<PostExpenseRequestBody>(
        requestBody: PostExpenseRequestBody(
            title: model.title,
            total: model.total,
            category: model.category.name,
            isRecurring: model.isRecurring,
            date: model.date));
  }

  //Helper methods
  List<ExpenseModel> convertResponseToExpenses(
      List<ExpenseResponse> responseList) {
    return responseList
        .map((responseObj) => ExpenseModel(
            id: responseObj.id,
            title: responseObj.title,
            total: responseObj.total,
            category: ExpenseCategory.values.firstWhere(
                (category) => category.name == responseObj.category),
            isRecurring: responseObj.isRecurring,
            date: responseObj.date))
        .toList();
  }

  void updateAverageExpenses(List<ExpenseModel> expenses) {
    Map<double, double> map = {};
    try {
      for (var expense in expenses) {
        var key = expense.date.month.toDouble() - 1;
        if (map.containsKey(key)) {
          map[key] = map[key]! + expense.total;
        } else {
          map[key] = expense.total;
        }
      }
    } catch (exception) {
      //suppress
    }
    monthlyExpenses.value = map;
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
    expPerType.value = map;
  }
}

enum DataState { loading, success, error }
