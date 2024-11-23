import 'package:flutter/material.dart';
import 'package:income_tally/views/add_edit_expense_view.dart';
import 'package:income_tally/views/main_view.dart';

import "services/helpers.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //root of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Income Tally",
      scrollBehavior: CustomScrollBehavior(),
      theme: ThemeData.light(useMaterial3: true),
      routes: {
        "/add_edit_expense": (context) => const AddExpenseView(),
      },
      home: const MainView(),
    );
  }
}
