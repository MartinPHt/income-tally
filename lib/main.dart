import "package:flutter/material.dart";
import "package:income_tally/views/MainTabBar.dart";

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MainTabBar(),
    );
  }
}
