import 'package:flutter/material.dart';
import 'package:income_tally/views/FavouritesPage.dart';
import 'package:income_tally/views/HomePage.dart';
import 'package:income_tally/views/SettingsPage.dart';

class MainTabBar extends StatefulWidget {
  const MainTabBar({super.key});

  @override
  State<StatefulWidget> createState() => MainTabBarState();
}

class MainTabBarState extends State<MainTabBar> {
  int _selectedIndex = 0;

  // List of pages for each tab
  final List<Widget> _pages = [
    const HomePage(),
    FavoritesPage(),
    const SettingsPage(),
  ];

  // Function to handle tab switching
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bottom TabBar with Rounded Corners'),
      ),
      body: _pages[_selectedIndex], // Displays the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon:_buildTabIconFromImage("lib/icons/house.png", 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildTabIcon(Icons.favorite, 1),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: _buildTabIcon(Icons.settings, 2),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  // Function to build the rounded tab icon with selection effect
  Widget _buildTabIcon(IconData icon, int index) {
    bool isSelected = _selectedIndex == index;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(20), // Round corners
      ),
      child: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.grey,
      ),
    );
  }

  // Function to build the rounded tab icon with selection effect
  Widget _buildTabIconFromImage(String imagePath, int index) {
    bool isSelected = _selectedIndex == index;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset(
        imagePath,
        height: 20,
        width: 20,
        color: isSelected ? Colors.white : null,
      ),
    );
  }
}