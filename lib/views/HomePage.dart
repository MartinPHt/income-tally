import 'package:flutter/material.dart';
import 'package:income_tally/views/RoundedContainer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
            //First rounded container
            Container(
                width: MediaQuery.of(context).size.width / 2,
                height: double.infinity,
                margin: const EdgeInsets.only(
                    left: 25, top: 25, right: 15, bottom: 25),
                constraints: const BoxConstraints(minWidth: 300),
                child: const RoundedContainer()),
            //Second rounded container
            Container(
                width: MediaQuery.of(context).size.width / 2,
                height: double.infinity,
                margin: const EdgeInsets.only(
                    left: 15, top: 25, right: 25, bottom: 25),
                constraints: const BoxConstraints(minWidth: 300),
                child: const RoundedContainer()),
          ]),
        ),
        const Expanded(
          flex: 2,
          child: Text("data"),
        ),
        const Expanded(
          flex: 1,
          child: Text("data"),
        ),
      ],
    );
  }
}
