import 'package:flutter/material.dart';

class TablePageHeader extends StatelessWidget {
  const TablePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
         Container(
           margin: const EdgeInsets.only(left: 25),
           child: const Text("Table",
           style: TextStyle(
             fontSize: 22,
             fontWeight: FontWeight.bold
           ),),
         )
      ],
    );
  }
}