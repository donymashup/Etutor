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

  final List<Widget> tabs = const [
    AttendedPage(),
    OngoingPage(),
    UpcomingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyBackground,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Test Series',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
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
                    _TabButton(
                      label: 'Attended',
                      selected: selectedIndex == 0,
                      onTap: () => setState(() => selectedIndex = 0),
                    ),
                    _TabButton(
                      label: 'Ongoing',
                      selected: selectedIndex == 1,
                      onTap: () => setState(() => selectedIndex = 1),
                    ),
                    _TabButton(
                      label: 'Upcoming',
                      selected: selectedIndex == 2,
                      onTap: () => setState(() => selectedIndex = 2),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(child: tabs[selectedIndex]),
          ],
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: selected ? AppColor.primaryColor.withOpacity(0.1) : Colors.transparent,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selected ? AppColor.primaryColor : AppColor.greyText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
