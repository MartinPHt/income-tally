import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:income_tally/Models/expense_model.dart';
import 'package:income_tally/widgets/rounded_container.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {PointerDeviceKind.touch, PointerDeviceKind.mouse};
}

abstract class AppColors {
  static const Color backgroundPurple = Color(0xffeee4f8);
  static const Color backgroundBlue = Color(0xffdfe0f3);
  static const Color contentColorPurple = Color(0xffd68df3);
  static const Color contentColorBlue = Color(0xff7ca5f1);
  static const Color mainGridLineColor = Color(0xffbfbfbf);
  static const Color textColor = Color(0xff424242);
  static const Color iconColor = Color(0xff000000);

  // Function to change the lightness of a color
  static Color changeLightness(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    final newLightness = (hsl.lightness + amount).clamp(0.0, 1.0);
    final newHsl = hsl.withLightness(newLightness);
    return newHsl.toColor();
  }
}

abstract class ChartHelper {
  //static fields
  static List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  static List<String> monthsShortened = [
    'J',
    'F',
    'M',
    'A',
    'M',
    'J',
    'J',
    'A',
    'S',
    'O',
    'N',
    'D'
  ];
}

abstract class AppStyles {
  static const lineChartHeadersStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 10,
    color: AppColors.textColor,
  );
}

abstract class IconGenerator {
  static Widget generateExpenseIcon(ExpenseCategory category,
      {double height = 50, double width = 50}) {
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
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: ExpenseCategoriesColors.collection[category],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        iconData,
        color: AppColors.iconColor,
      ),
    );
  }
}

abstract class DialogHelper {
  static void showExpenseInfo(BuildContext context,
      {required ExpenseModel expense}) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              color: Theme.of(context).canvasColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  IconButton(
                    style:
                        TextButton.styleFrom(overlayColor: Colors.transparent),
                    onPressed: () => Navigator.pop(context),
                    icon: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).canvasColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 25,
                        height: 25,
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: Theme.of(context).hintColor,
                        )),
                  ),
                ]),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  IconGenerator.generateExpenseIcon(expense.category),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    expense.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                const SizedBox(height: 15),
                Text(
                  '${expense.total} BGN',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${expense.date.month}/${expense.date.year}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 15),
                Text(
                  'Category: ${expense.category.name}',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 5),
                Text(
                  expense.isRecurring ? 'Recurring' : 'Not recurring',
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
  }
}

abstract class StringFormatter {
  static String formatDateToDMY(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
  }
}
