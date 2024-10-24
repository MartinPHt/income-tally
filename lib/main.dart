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
      title: "Income Tally",
      scrollBehavior: CustomScrollBehavior(),
      theme: ThemeData.light(useMaterial3: true),
      home: const MainTabBar(),
    );
  }
}
