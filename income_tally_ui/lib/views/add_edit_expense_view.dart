import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:income_tally/Models/expense_model.dart';
import 'package:income_tally/services/data_controller.dart';
import 'package:income_tally/widgets/rounded_container.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({super.key});

  @override
  State<StatefulWidget> createState() => AddExpenseViewState();
}

class AddExpenseViewState extends State<AddExpenseView> {
  //used for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //input controllers and fields storing data
  TextEditingController titleController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String selectedExpenseCategory = ExpenseCategory.Other.name;
  bool isRecurring = false;
  List<String> expenseTypes = [
    'Housing',
    'Food',
    'Transportation',
    'Health',
    'Education',
    'Entertainment',
    'Clothing',
    'Other'
  ];
  bool isHandlingInput = false;

  //used only if user edits already existing expense
  ExpenseModel? passedModel;
  bool modelLoaded = false;

  @override
  void dispose() {
    titleController.dispose();
    totalController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dateController.addListener(() {
      if (isHandlingInput) return; // Prevent recursion

      isHandlingInput = true;
      final text = dateController.text;

      if (text.length == 2 && !text.contains('/')) {
        dateController.value = TextEditingValue(
          text: '$text/',
          selection: TextSelection.fromPosition(
            TextPosition(offset: dateController.text.length + 1),
          ),
        );
      } else if (text.endsWith('/') && text.length > 2) {
        // Prevent re-adding '/' after deletion
        final prevChar = text[text.length - 2];
        if (prevChar != '/') {
          dateController.value = TextEditingValue(
            text: text.substring(0, text.length - 1),
            selection: TextSelection.fromPosition(
              TextPosition(offset: text.length - 1),
            ),
          );
        }
      }

      isHandlingInput = false;
    });
  }

  String? _validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title cannot be empty';
    }

    return null;
  }

  String? _validateTotal(String? value) {
    if (value == null || value.isEmpty) {
      return 'Total cannot be empty';
    }

    final regex = RegExp(r'^\d+(\.\d+)?$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid total';
    }

    return null;
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Date cannot be empty. Please enter a Date';
    }

    final regex = RegExp(r'^(0[1-9]|1[0-2])\/\d{4}$');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid date in MM/YYYY format';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    //get arguments
    if (!modelLoaded) {
      var arguments = ModalRoute.of(context)?.settings.arguments;
      passedModel = arguments as ExpenseModel?;
      if (passedModel != null) {
        titleController.text = passedModel!.title;
        totalController.text = passedModel!.total.toString();
        dateController.text =
            "${passedModel!.date.month}/${passedModel!.date.year}";
        selectedExpenseCategory = passedModel!.category.name;
        isRecurring = passedModel!.isRecurring;
      }
      modelLoaded = true;
    }

    double startHeight = MediaQuery.of(context).size.height / 10;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonsHeight = 50;

    double decorWidth;
    double decorHeight;
    double widgetsMaxWidth;
    double mainLeftMargin;
    double decorRight;
    double decorBottom;
    bool isCancelButtonVisible;

    if (screenWidth <= 600) {
      decorWidth = screenWidth * 0.55;
      decorHeight = screenHeight * 0.30;
      widgetsMaxWidth = screenWidth * 0.60;
      mainLeftMargin = 50;
      decorRight = 30;
      decorBottom = 50;
      isCancelButtonVisible = false;
    } else if (screenWidth <= 1280) {
      decorWidth = screenWidth * 0.50;
      decorHeight = screenHeight * 0.60;
      widgetsMaxWidth = screenWidth * 0.35;
      mainLeftMargin = 120;
      decorRight = 60;
      decorBottom = 80;
      isCancelButtonVisible = false;
    } else if (screenWidth <= 1680) {
      decorWidth = screenWidth * 0.50;
      decorHeight = screenHeight * 0.60;
      widgetsMaxWidth = screenWidth * 0.30;
      mainLeftMargin = 200;
      decorRight = 200;
      decorBottom = 120;
      isCancelButtonVisible = true;
    } else {
      decorWidth = screenWidth * 0.50;
      decorHeight = screenHeight * 0.60;
      widgetsMaxWidth = screenWidth * 0.20;
      mainLeftMargin = 450;
      decorRight = 450;
      decorBottom = 120;
      isCancelButtonVisible = true;
    }

    if (screenWidth <= 500 && screenHeight <= 850) {
      decorWidth = 0;
      decorHeight = 0;
    }

    return SafeArea(
        child: Scaffold(
      body: Form(
        key: _formKey,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              //bottom image
              Positioned(
                  right: decorRight,
                  bottom: decorBottom,
                  child: Image.asset(
                    'lib/icons/decor1.png',
                    width: decorWidth,
                    height: decorHeight,
                    alignment: Alignment.bottomRight,
                  )),
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.only(
                      left: mainLeftMargin, right: 30, bottom: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: startHeight,
                      ),
                      Text(passedModel == null ? "New expense" : "Edit expense",
                          style: const TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold)),
                      const Text("Please fill out all fields",
                          style: TextStyle(
                            fontSize: 16,
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        child: const Text("Title",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                          constraints:
                              BoxConstraints(maxWidth: widgetsMaxWidth),
                          child: TextFormField(
                            controller: titleController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Title"),
                            validator: _validateTitle,
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        child: const Text("Total",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                          constraints:
                              BoxConstraints(maxWidth: widgetsMaxWidth),
                          child: TextFormField(
                            controller: totalController,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"^\d+(\.(\d+)?)?$")),
                            ],
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Total',
                                hintStyle: TextStyle()),
                            validator: _validateTotal,
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        child: const Text("Category",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.only(bottom: 10),
                      //   child: DropdownMenu<String>(
                      //     width: widgetsMaxWidth,
                      //     inputDecorationTheme: const InputDecorationTheme(
                      //         isDense: true, border: OutlineInputBorder()),
                      //     initialSelection: selectedExpenseCategory.isNotEmpty
                      //         ? selectedExpenseCategory
                      //         : expenseTypes.first,
                      //     onSelected: (String? value) {},
                      //     dropdownMenuEntries: expenseTypes.map((value) {
                      //       return DropdownMenuEntry(
                      //           value: value, label: value);
                      //     }).toList(),
                      //   ),
                      // ),
                      Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                              width: widgetsMaxWidth,
                              child: DropdownButtonFormField(
                                value: selectedExpenseCategory,
                                borderRadius: BorderRadius.circular(5),
                                focusColor: Colors.transparent,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                items: expenseTypes.map((value) {
                                  return DropdownMenuItem(
                                      value: value, child: Text(value));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedExpenseCategory =
                                        value ?? ExpenseCategory.Other.name;
                                  });
                                },
                              ))),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 10),
                        child: const Text("Date",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      Container(
                          constraints:
                              BoxConstraints(maxWidth: widgetsMaxWidth),
                          child: TextFormField(
                            controller: dateController,
                            keyboardType: const TextInputType.numberWithOptions(
                                signed: true, decimal: true),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(7),
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"^\d+(\/(\d+)?)?$")),
                            ],
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'MM/YYYY',
                                hintStyle: TextStyle()),
                            validator: _validateDate,
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 15, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: const Text("Recurring",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Checkbox(
                                value: isRecurring,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isRecurring = value ?? isRecurring;
                                  });
                                }),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: buttonsHeight,
                            margin: const EdgeInsets.only(left: 5, right: 15),
                            width: isCancelButtonVisible
                                ? (widgetsMaxWidth - 40) * 0.50
                                : (widgetsMaxWidth - 40) * 0.65,
                            child: FilledButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (passedModel == null) {
                                      doAddNewExpense(context);
                                    } else {
                                      doEditNewExpense(context);
                                    }
                                  }
                                },
                                child:
                                    Text(passedModel == null ? 'Add' : 'Save')),
                          ),
                          Visibility(
                            visible: isCancelButtonVisible,
                            child: Container(
                              height: buttonsHeight,
                              margin: const EdgeInsets.only(left: 15, right: 5),
                              width: (widgetsMaxWidth - 40) * 0.50,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        width: 1.5,
                                        color: Theme.of(context).primaryColor)),
                                child: FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).canvasColor,
                                      foregroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              //Button
              SizedBox(
                height: 80,
                child: Row(
                  children: [
                    Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.only(left: 20, top: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              overlayColor: Colors.transparent),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.arrow_back),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void doAddNewExpense(BuildContext context) {
    var dateParts = dateController.text.split('/');
    int month = int.parse(dateParts[0]);
    int year = int.parse(dateParts[1]);
    var expense = ExpenseModel(
        id: -1,
        title: titleController.text,
        total: double.parse(totalController.text),
        category: ExpenseCategory.values.firstWhere(
            (e) => e.name == selectedExpenseCategory,
            orElse: () => ExpenseCategory.Other),
        isRecurring: isRecurring,
        date: DateTime(year, month));

    var result = DataController.instance.performAddExpense(expense);
    if (result) {
      showDialogWithAutoClose(context, isSuccessful: true, func: () {
        Navigator.pop(context);
      });
    } else {
      //
    }
  }

  void doEditNewExpense(BuildContext context) {
    var dateParts = dateController.text.split('/');
    int month = int.parse(dateParts[0]);
    int year = int.parse(dateParts[1]);
    var expense = ExpenseModel(
        id: passedModel!.id,
        title: titleController.text,
        total: double.parse(totalController.text),
        category: ExpenseCategory.values.firstWhere(
            (e) => e.name == selectedExpenseCategory,
            orElse: () => ExpenseCategory.Other),
        isRecurring: isRecurring,
        date: DateTime(year, month));

    var result = DataController.instance.performAddExpense(expense);
    if (result) {
      showDialogWithAutoClose(context, isSuccessful: true, func: () {
        Navigator.pop(context);
      });
    } else {
      //
    }
  }

  // Function to show a dialog and close it after 2 seconds
  Future showDialogWithAutoClose(BuildContext context,
      {required bool isSuccessful, required Function() func}) async {
    bool isClosed = false;

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted && !isClosed) {
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
                      "lib/icons/successIcon.png",
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      isSuccessful ? "Successful" : "Error",
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
