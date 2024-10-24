import 'package:flutter/material.dart';

import 'RoundedContainer.dart';

class InsidesPage extends StatefulWidget {
  const InsidesPage({super.key});

  @override
  State<StatefulWidget> createState() => InsidesPageState();
}

class InsidesPageState extends State<InsidesPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Center(
              child: Text(
                'Favorites Page',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
        Row(
          children: [
            RoundedContainer(
              child: Column(
                children: [
                  Text("AAAAAAAAAAA"),
                  Text("AAAAAAAAAAA"),
                  Text("AAAAAAAAAAA"),
                  Text("AAAAAAAAAAA"),
                  Text("AAAAAAAAAAA"),
                  Text("AAAAAAAAAAA"),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
