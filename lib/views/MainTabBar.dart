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

  // List of page headers
  final List<Widget> _pageHeaders = [
    HomePageHeader(),
    const Text("Insights"),
    const Text("Settings"),
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
        title: _pageHeaders[_selectedIndex],
      ),
      body: _pages[_selectedIndex], // Displays the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon:_buildTabIconFromImages("lib/icons/house.png", "lib/icons/houseSelected.png", 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _buildTabIconFromImages("lib/icons/chart.png", "lib/icons/chartSelected.png", 1),
            label: 'Insights',
          ),
          BottomNavigationBarItem(
            icon: _buildTabIconFromImages("lib/icons/settings.png", "lib/icons/settingsSelected.png", 2),
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

  Widget _buildTabIconFromImages(String unselectedImagePath, String selectedImagePath, int index) {
    bool isSelected = _selectedIndex == index;

    return Container(
      padding: const EdgeInsets.all(8),
      child: Image.asset(
        isSelected ? selectedImagePath : unselectedImagePath,
        color: isSelected ? null : Colors.grey,
        height: 25,
        width: 25,
      ),
    );
  }
}

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
     children: [
       Column(
         children: [
           Image.asset(
             "lib/icons/user.png",
             height: 50,
             width: 50,
           ),
         ]
       ),
       const SizedBox(
         width: 5,
       ),
       const Column(
         children: [
           Text("Hello",
           style: TextStyle(
             fontSize: 14
           )),
           Text("User",
           style: TextStyle(
             fontWeight: FontWeight.bold,
             fontSize: 16
           ),)
         ],
       ),
       const Column()
     ],
    );
  }

}