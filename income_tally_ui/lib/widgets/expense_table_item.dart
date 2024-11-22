import 'package:flutter/material.dart';
import 'package:income_tally/services/helpers.dart';
import '../Models/expense_model.dart';

class ExpenseTableItem extends StatelessWidget {
  final double height;
  final ExpenseModel model;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const ExpenseTableItem(
      {super.key,
      this.height = 50,
      required this.model,
      this.margin,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(overlayColor: Colors.transparent),
      onPressed: () {
        DialogHelper.showExpenseEditActions(context, expense: model);
      },
      child: Container(
        margin: margin,
        padding: padding,
        child: Row(
          children: [
            // Icon
            IconGenerator.generateExpenseIcon(model.category),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      StringFormatter.formatDateToDMY(model.date),
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Text(
                '${model.total.toStringAsFixed(2)}BGN',
                style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w700),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 18,)
          ],
        ),
      ),
    );
  }
}
