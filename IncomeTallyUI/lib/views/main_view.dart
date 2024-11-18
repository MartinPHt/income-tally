import 'package:flutter/material.dart';
import 'package:income_tally/services/helpers.dart';
import 'package:income_tally/views/insights_page.dart';
import 'package:income_tally/views/home_page.dart';
import 'package:income_tally/views/table_page.dart';
import 'package:income_tally/widgets/home_page_header.dart';
import 'package:income_tally/widgets/insights_page_header.dart';
import 'package:income_tally/widgets/table_page_header.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  // List of pages for each tab
  final Map<int, Widget> _pages = {
    0: HomePage(),
    1: const InsidesPage(),
    2: const TablePage(),
  };

  // List of page headers
  final List<Widget> _pageHeaders = [
    const HomePageHeader(),
    const InsightsPageHeader(),
    const TablePageHeader(),
  ];

  // Function to handle tab switching
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _generateSideNavButton(String unselectedImagePath,
      String selectedImagePath, Widget label, int index) {
    return FilledButton(
      onPressed: () {
        _onItemTapped(index);
      },
      style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Theme.of(context).canvasColor,
          overlayColor: Colors.deepPurple[300],
          surfaceTintColor: Colors.deepPurple[100],
          foregroundColor: Colors.grey[700]),
      child: Center(
        child: Row(
          children: [
            _buildTabIconFromImages(
                unselectedImagePath, selectedImagePath, index),
            label
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool bottomNavBarVisible = true;
    bool sideMenuVisible = false;

    if (MediaQuery.of(context).size.width > 1200) {
      sideMenuVisible = true;
      bottomNavBarVisible = false;
    }

    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            Visibility(
              visible: sideMenuVisible,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.20,
                constraints: const BoxConstraints(maxWidth: 300),
                color: Theme.of(context).canvasColor,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Center(
                      child: SizedBox(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset('lib/icons/logo.png'),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.only(left: 25, right: 25),
                      height: 2,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 15),
                    _generateSideNavButton('lib/icons/house.png',
                        'lib/icons/houseSelected.png', const Text('Home'), 0),
                    const SizedBox(height: 5),
                    _generateSideNavButton(
                        'lib/icons/chart.png',
                        'lib/icons/chartSelected.png',
                        const Text('Insights'),
                        1),
                    const SizedBox(height: 5),
                    _generateSideNavButton(
                        'lib/icons/settings.png',
                        'lib/icons/settingsSelected.png',
                        const Text('Home'),
                        2),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [
                      0.2,
                      0.6
                    ],
                        colors: [
                      AppColors.backgroundBlue,
                      AppColors.backgroundPurple,
                    ])),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) {
                    return Stack(children: [
                      FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    ]);
                  },
                  child: Column(
                    key: ValueKey<int>(_selectedIndex),
                    children: [
                      SizedBox(
                        height: 70,
                        child: _pageHeaders[_selectedIndex],
                      ),
                      Expanded(child: _pages[_selectedIndex]!),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ), // Displays the selected page
        bottomNavigationBar: Visibility(
          visible: bottomNavBarVisible,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: _buildTabIconFromImages(
                    "lib/icons/house.png", "lib/icons/houseSelected.png", 0),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildTabIconFromImages(
                    "lib/icons/chart.png", "lib/icons/chartSelected.png", 1),
                label: 'Insights',
              ),
              BottomNavigationBarItem(
                icon: _buildTabIconFromImages("lib/icons/settings.png",
                    "lib/icons/settingsSelected.png", 2),
                label: 'Expenses',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabIconFromImages(
      String unselectedImagePath, String selectedImagePath, int index) {
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
