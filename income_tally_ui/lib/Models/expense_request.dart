import 'package:income_tally/Models/request_base_model.dart';

class PostExpenseRequestBody extends HttpPostRequestBody {
  final String title;
  final double total;
  final String category;
  final bool isRecurring;
  final DateTime date;

  PostExpenseRequestBody(
      {required this.title,
      required this.total,
      required this.category,
      required this.isRecurring,
      required this.date});
}

class PutExpenseRequestBody extends HttpPutRequestBody {
  final String title;
  final double total;
  final String category;
  final bool isRecurring;
  final DateTime date;

  PutExpenseRequestBody(
      {required super.id,
      required this.title,
      required this.total,
      required this.category,
      required this.isRecurring,
      required this.date});
}
