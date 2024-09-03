import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:trial_palmbook/common/discussion.dart';
import '../common/mess_menu.dart';
import 'gatepass_requests.dart';
import 'Lost_And_Found.dart';
import 'home.dart';



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const homepage(),
    const test3(),
    const GatepassRequests(),
    const Lost_And_Found(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  Future<bool> _onWillPop() async {
    if (_currentIndex > 0) {
      // Go to the previous page in the PageView
      _onItemTapped(0);
      return false; // Prevent the app from closing
    } else {
      return true; // Allow the app to close if on the first page
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          backgroundColor: const Color(0xFF7785FC),
          items: [
            BottomNavigationBarItem(
              icon: _currentIndex == 0
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 1
                  ? const Icon(Icons.people)
                  : const Icon(Icons.people_alt_outlined),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 2
                  ? const Icon(Icons.check_box)
                  : const Icon(Icons.check_box_outlined),
              label: 'Requests',
            ),
            BottomNavigationBarItem(
              icon: _currentIndex == 3
                  ? const Icon(Icons.lightbulb)
                  : const Icon(Icons.lightbulb_outlined),
              label: 'Lost & Found',
            ),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}