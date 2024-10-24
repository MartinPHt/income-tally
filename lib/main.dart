import "package:flutter/material.dart";
import "package:income_tally/views/MainTabBar.dart";

import "models/Helpers.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //root of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      title: "Income Tally",
      theme: ThemeData.light(),
      home: const MainTabBar(),
    );
  }
}
