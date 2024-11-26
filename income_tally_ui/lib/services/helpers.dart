import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:income_tally/Models/expense_model.dart';
import 'package:income_tally/services/data_controller.dart';
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

  static void showExpenseEditActions(BuildContext context,
      {required ExpenseModel expense}) {
    //TODO: this breaks if screen height is tight. Fix this
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
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: TextButton(
                        onPressed: () async {
                          await Navigator.pushNamed(context, "/add_edit_expense",
                              arguments: expense);
                          if (context.mounted){
                            Navigator.pop(context);
                          }
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xff9d6fed),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: const Icon(
                          Icons.edit_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: TextButton(
                        onPressed: () {
                          DialogHelper.showConfirmationDialog(context,
                              title:
                                  "Are you sure you want to delete '${expense.title}' expense",
                              onConfirmed: () async {
                            var result = await DataController.instance
                                .performDeleteExpense(expense.id);
                            if (result) {
                              await DataController.instance
                                  .performExpensesFetch(
                                      updateMonthlyExpenses: true);
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            } else {
                              if (context.mounted) {
                                showDialogWithAutoClose(context,
                                    isSuccessful: false, func: () {});
                              }
                            }
                          });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xfff14646),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: const Icon(
                          Icons.delete_outline,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        });
  }

  static void showConfirmationDialog(BuildContext context,
      {required String title,
      Function()? onConfirmed,
      Function()? onCanceled,
      String confirmTitle = "Yes",
      String cancelTitle = "No"}) async {
    bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Confirmation",
            style: TextStyle(fontSize: 18),
          ),
          content: Text("$title?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(confirmTitle),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(cancelTitle),
            ),
          ],
        );
      },
    );

    // Handle the result
    if (confirmed == true && onConfirmed != null) {
      onConfirmed();
    } else if (confirmed == false && onCanceled != null) {
      onCanceled();
    }
  }

  // Function to show a dialog and close it after 2 seconds
  static Future<void> showDialogWithAutoClose(BuildContext context,
      {required bool isSuccessful, required Function() func}) async {
    bool isClosed = false;

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          if (context.mounted && !isClosed) {
            Navigator.of(context).pop(); // This will close the dialog
          }
        });

        return Dialog(
          child: RoundedContainer(
            height: 200,
            width: 120,
            child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  isClosed = true;
                },
                style: TextButton.styleFrom(overlayColor: Colors.transparent),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      isSuccessful
                          ? "lib/icons/successIcon.png"
                          : "lib/icons/errorIcon.png",
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      isSuccessful ? "Successful" : "Error. Try again later.",
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                )),
          ),
        );
      },
    ).whenComplete(() {
      bool isClosed = false;
    });

    func();
  }
}

abstract class StringFormatter {
  static String formatDateToDMY(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}';
  }
}

abstract class JsonSerialize {
  // Deserialize JSON to object
  static T deserialize<T>(String responseBody) {
    try {
      return jsonDecode(responseBody) as T;
    } catch (e) {
      throw FormatException(
          'JSON: Error deserializing the response body to ${T.runtimeType.toString()}. Exception body: $e');
    }
  }

  // Deserialize JSON to object
  static String serialize<T>(T object) {
    try {
      return jsonEncode(object);
    } catch (e) {
      throw FormatException(
          'JSON: Error serializing the ${T.runtimeType.toString()} object. Exception body: $e');
    }
  }
}
