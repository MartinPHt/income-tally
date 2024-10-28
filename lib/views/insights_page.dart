import 'package:flutter/material.dart';

import '../widgets/rounded_container.dart';

class InsidesPage extends StatefulWidget {
  const InsidesPage({super.key});

  final int graphCount = 5;

  @override
  State<StatefulWidget> createState() => InsidesPageState();
}

class InsidesPageState extends State<InsidesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
      child: ListView(
          physics: const BouncingScrollPhysics(),
          children: List.generate(widget.graphCount, (index) {
        return Container(
            height: MediaQuery.of(context).size.height / widget.graphCount,
            constraints: const BoxConstraints(minHeight: 300),
            margin: const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 20),
            child: const RoundedContainer());
      }
      )),
    );
  }
}
