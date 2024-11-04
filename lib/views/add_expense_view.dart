import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpenseView extends StatefulWidget {
  const AddExpenseView({super.key});

  @override
  State<StatefulWidget> createState() => AddExpenseViewState();
}

class AddExpenseViewState extends State<AddExpenseView> {
  TextEditingController titleTextController = TextEditingController();
  TextEditingController totalTextController = TextEditingController();
  bool isRecurring = false;
  String selectedExpenseType = "";
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

  @override
  void dispose() {
    titleTextController.dispose();
    totalTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double startHeight = MediaQuery.of(context).size.height / 6;
    double widgetsMaxWidth = 250;

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
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
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: startHeight,
                  ),
                  const Text("New expense",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
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
                      constraints: BoxConstraints(maxWidth: widgetsMaxWidth),
                      child: TextField(
                        controller: titleTextController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: "Title"),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    child: const Text("Total",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                      constraints: BoxConstraints(maxWidth: widgetsMaxWidth),
                      child: TextField(
                        controller: totalTextController,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r"^\d+(\.(\d+)?)?$")),
                        ],
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(), hintText: 'Total'),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 10),
                    child: const Text("Category",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 10),
                    constraints: BoxConstraints(maxWidth: widgetsMaxWidth),
                    child: DropdownMenu<String>(
                      width: MediaQuery.of(context).size.width,
                      initialSelection: selectedExpenseType.isNotEmpty
                          ? selectedExpenseType
                          : expenseTypes.first,
                      onSelected: (String? value) {},
                      dropdownMenuEntries: expenseTypes.map((value) {
                        return DropdownMenuEntry(value: value, label: value);
                      }).toList(),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 30, top: 10, right: 30, bottom: 10),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: const Text("Recurring", style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
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
                  Container(
                    height: 40,
                    child: FilledButton(onPressed: () {}, child: Container()),
                    constraints: const BoxConstraints(
                      maxWidth: 200
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
