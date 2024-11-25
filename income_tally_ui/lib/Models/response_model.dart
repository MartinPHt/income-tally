class HttpResponse {
  final int id;

  HttpResponse({required this.id});
}

class ExpenseResponse extends HttpResponse {
  final String title;
  final double total;
  final String category;
  final bool isRecurring;
  final DateTime date;

  ExpenseResponse(
      {required super.id,
      required this.title,
      required this.total,
      required this.category,
      required this.isRecurring,
      required this.date});

  ExpenseResponse.fromJson(Map<String, dynamic> json)
      : title = json['title'].toString(),
        total = double.parse(json['total'].toString()),
        category = json['category'].toString(),
        isRecurring = bool.parse(json['isRecurring'].toString()),
        date = DateTime.parse(json['date'].toString()),
        super(id: int.parse(json['id'].toString()));

  Map<String, dynamic> toJson() {
    return {
      'id': super.id,
      'title': title,
      'total': total,
      'category': category,
      'isRecurring': isRecurring,
      'date': date.toIso8601String(),
    };
  }
}
