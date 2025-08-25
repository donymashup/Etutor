import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/features/live/screens/ongoing_live_screen.dart';
import 'package:etutor/features/live/screens/recorded_live_screen.dart';
import 'package:etutor/features/live/screens/recorded_navigator.dart';
import 'package:etutor/features/live/screens/recorded_years_screen.dart';
import 'package:etutor/features/live/screens/upcoming_live_screen.dart';
import 'package:etutor/features/test_series/widgets/tapbtn_testseries.dart';
import 'package:flutter/material.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen>
    with SingleTickerProviderStateMixin {
      
  int selectedIndex = 0;
  late final PageController _pageController;


  final List<Widget> _body = [
    OngoingLiveScreen(),
    UpcomingLiveScreen(),
    RecordedNavigator()
  ];

  @override
  void initState() {
    _pageController = PageController(initialPage: selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
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
                  "Live Classes",
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
                      label: 'Recorded',
                      selected: selectedIndex == 2,
                      onTap: () => _onTabSelected(2),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => selectedIndex = index);
                  },
                  children: _body,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
