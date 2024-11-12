class ExpenseModel {
  final String title;
  final double total;
  final ExpenseCategory category;
  final bool isRecurring;

  ExpenseModel({required this.title, required this.total, required this.category, required this.isRecurring});

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