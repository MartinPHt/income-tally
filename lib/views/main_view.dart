import 'package:flutter/material.dart';
import 'package:income_tally/services/helpers.dart';
import 'package:income_tally/views/insights_page.dart';
import 'package:income_tally/views/home_page.dart';
import 'package:income_tally/views/table_page.dart';
import 'package:income_tally/widgets/home_page_header.dart';
import 'package:income_tally/widgets/insights_page_header.dart';



class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  // List of pages for each tab
  final List<Widget> _pages = [
    const HomePage(),
    const InsidesPage(),
    const TablePage(),
  ];

  // List of page headers
  final List<Widget> _pageHeaders = [
    const HomePageHeader(),
    const InsightsPageHeader(),
    const Text("Table"),
  ];

  // Function to handle tab switching
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: const [0.2, 0.6],
                  colors: [
                AppColors.instance.backgroundBlue,
                AppColors.instance.backgroundPurple,
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
                // Positioned.fill(
                //   child: FadeTransition(
                //     opacity:
                //         Tween<double>(begin: 1.0, end: 0.0).animate(animation),
                //     child: Container(
                //       color: Colors.white,
                //     ),
                //   ),
                // )
              ]);
            },
            child: Column(
              key: ValueKey<int>(_selectedIndex),
              children: [
                SizedBox(
                  height: 70,
                  child: _pageHeaders[_selectedIndex],
                ),
                Expanded(child: _pages[_selectedIndex]),
              ],
            ),
          ),
        ), // Displays the selected page
        bottomNavigationBar: BottomNavigationBar(
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
              icon: _buildTabIconFromImages(
                  "lib/icons/settings.png", "lib/icons/settingsSelected.png", 2),
              label: 'Settings',
            ),
          ],
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
