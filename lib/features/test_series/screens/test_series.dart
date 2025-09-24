import 'package:etutor/features/test_series/widgets/tapbtn_testseries.dart';
import 'package:flutter/material.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/test_series/screens/attended_testseries.dart';
import 'package:etutor/features/test_series/screens/ongoing_testseries.dart';
import 'package:etutor/features/test_series/screens/upcoming_testseries.dart';

class TestSeriesPage extends StatefulWidget {
  const TestSeriesPage({super.key});

  @override
  State<TestSeriesPage> createState() => _TestSeriesPageState();
}

class _TestSeriesPageState extends State<TestSeriesPage> {
  int selectedIndex = 0;
  late final PageController _pageController;

  final List<Widget> tabs = const [
    OngoingPage(),
    UpcomingPage(),
    AttendedPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabSelected(int index) {
    setState(() => selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 10),
                child: const Text(
                  "Test Series",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColor.blackColor,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    TabButton(
                      label: 'Ongoing',
                      selected: selectedIndex == 0,
                      onTap: () => _onTabSelected(0),
                    ),
                     TabButton(
                      label: 'Upcoming',
                      selected: selectedIndex == 1,
                      onTap: () => _onTabSelected(1),
                    ),
                    TabButton(
                      label: 'Attended',
                      selected: selectedIndex == 2,
                      onTap: () => _onTabSelected(2),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => selectedIndex = index);
                },
                children: tabs,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
