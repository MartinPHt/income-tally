import 'package:flutter/material.dart';

class ExpenseModel {
  final int id;
  final String title;
  final double total;
  final ExpenseCategory category;
  final bool isRecurring;
  final DateTime date;

  ExpenseModel(
      {required this.id,
      required this.title,
      required this.total,
      required this.category,
      required this.isRecurring,
      required this.date});
}

enum ExpenseCategory {
  Housing,
  Food,
  Transportation,
  Health,
  Education,
  Entertainment,
  Clothing,
  Other
}

class ExpenseCategoriesColors {
  static Map<ExpenseCategory, Color> collection = {
    ExpenseCategory.Housing: const Color(0xffd6cfe4),
    ExpenseCategory.Food: const Color(0xffcdbfdc),
    ExpenseCategory.Transportation: const Color(0xffc0afd5),
    ExpenseCategory.Health: const Color(0xffc1a6d6),
    ExpenseCategory.Education: const Color(0xffb498cf),
    ExpenseCategory.Entertainment: const Color(0xffa784cc),
    ExpenseCategory.Clothing: const Color(0xffa177ca),
    ExpenseCategory.Other: const Color(0xff9864d3)
  };
}
