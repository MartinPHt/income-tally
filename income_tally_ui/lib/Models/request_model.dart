import 'dart:convert';

class HttpPostRequestBody {}

class HttpPutRequestBody {
  final int id;

  HttpPutRequestBody({required this.id});
}

//Expenses request
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

  PostExpenseRequestBody.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        total = json['total'],
        category = json['category'],
        isRecurring = json['isRecurring'],
        date = json['date'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'total': total,
      'category': category,
      'isRecurring': isRecurring,
      'date': date.toIso8601String(),
    };
  }
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

  PutExpenseRequestBody.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        total = json['total'],
        category = json['category'],
        isRecurring = json['isRecurring'],
        date = json['date'],
        super(id: json['id']);

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'title': title,
      'total': total,
      'category': category,
      'isRecurring': isRecurring,
      'date': date,
    };
  }
}
