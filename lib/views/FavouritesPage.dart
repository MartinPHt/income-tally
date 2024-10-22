import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});


  @override
  State<StatefulWidget> createState() => FavoritesPageState();
}

class FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Favorites Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}