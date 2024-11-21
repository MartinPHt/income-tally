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
    return Container(
      margin: margin,
      padding: padding,
      child: Row(
        children: [
          // Icon Container
          Container(
            height: height,
            width: height,
            decoration: BoxDecoration(
              color: ExpenseCategoriesColors.collection[model.category],
              borderRadius: BorderRadius.circular(20),
            ),
            child: generateIcon(model.category),
          ),
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
    );
  }

  Widget generateIcon(ExpenseCategory category) {
    IconData iconData;
    if (category == ExpenseCategory.Housing) {
      iconData = Icons.home_outlined;
    } else if (category == ExpenseCategory.Food) {
      iconData = Icons.local_grocery_store_outlined;
    } else if (category == ExpenseCategory.Clothing) {
      iconData = Icons.local_mall_outlined;
    } else if (category == ExpenseCategory.Education) {
      iconData = Icons.school_outlined;
    } else if (category == ExpenseCategory.Health) {
      iconData = Icons.local_hospital_outlined;
    } else if (category == ExpenseCategory.Transportation) {
      iconData = Icons.emoji_transportation;
    } else if (category == ExpenseCategory.Entertainment) {
      iconData = Icons.local_fire_department_outlined;
    } else {
      iconData = Icons.account_balance_wallet_outlined;
    }
    return Icon(iconData);
  }
}
