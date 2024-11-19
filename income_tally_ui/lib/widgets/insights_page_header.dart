import 'package:flutter/material.dart';

class InsightsPageHeader extends StatelessWidget {
  const InsightsPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Container(
           margin: const EdgeInsets.only(left: 25),
           child: const Text("This Month",
           style: TextStyle(
             fontSize: 22,
             fontWeight: FontWeight.bold
           ),),
         )
      ],
    );
  }
}