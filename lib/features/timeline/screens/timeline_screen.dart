// timeline_screen.dart
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/timeline/widgets/calender_strip.dart';
import 'package:etutor/features/timeline/widgets/timeline_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  DateTime selectedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();
  final List<DateTime> days = List.generate(
    30,
    (index) => DateTime.now().subtract(Duration(days: 29 - index)),
  );

  final List<Map<String, dynamic>> mockTimelineData = [
    {
      'type': 'video',
      'title': 'Crop Production',
      'subtitle': 'Class Video',
      'time': '3:36:46 PM',
      'color': Colors.deepOrange,
      'icon': Icons.play_circle_fill,
    },
    {
      'type': 'test',
      'title': 'Alphabet Test',
      'subtitle': 'Practice Test',
      'time': '2:00:00 PM',
      'color': Colors.blue,
      'icon': Icons.format_list_bulleted,
    },
    {
      'type': 'material',
      'title': 'Blood Relation (SB)',
      'subtitle': 'Study Material',
      'time': '1:20:10 PM',
      'color': Colors.red,
      'icon': Icons.description,
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title:  Text(
              "Timeline",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
     ),
      body: SafeArea(
        child: Column(
          children: [
            CalendarStrip(
              days: days,
              selectedDate: selectedDate,
              scrollController: _scrollController,
              onDateSelected: (date) => setState(() => selectedDate = date),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  DateFormat('EEEE, d MMMM').format(selectedDate),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 20),
                itemCount: mockTimelineData.length,
                itemBuilder: (context, index) {
                  final item = mockTimelineData[index];
                  return TimelineItem(
                    icon: item['icon'],
                    color: item['color'],
                    title: item['title'],
                    subtitle: item['subtitle'],
                    time: item['time'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
