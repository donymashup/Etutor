import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/home/screen/home_screen.dart';
import 'package:etutor/features/live/screens/live_screen.dart';
import 'package:etutor/features/my_course/screens/my_course.dart';
import 'package:etutor/features/test_series/screens/test_series.dart';
import 'package:flutter/material.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    MyCoursePage(),
    LiveScreen(),
    TestSeriesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentIndex == 0,
      onPopInvoked: (didPop) {
        if (!didPop && _currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: AppColor.primaryColor,
          unselectedItemColor: AppColor.greyText,
          backgroundColor: AppColor.whiteColor,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'My Course',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.live_tv),
              label: 'Live',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Test Series',
            ),
          ],
        ),
      ),
    );
  }
}