import 'package:flutter/material.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Column(children: [
            Image.asset(
              "lib/icons/user.png",
              height: 50,
              width: 50,
            ),
          ]),
          const SizedBox(
            width: 5,
          ),
          const Column(
            children: [
              Text("Hello", style: TextStyle(fontSize: 14)),
              Text(
                "User",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
          const Column()
        ],
      ),
    );
  }
}