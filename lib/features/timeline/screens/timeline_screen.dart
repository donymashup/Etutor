import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/subscribed_course/provider/subcribed_course_provider.dart';
import 'package:etutor/features/timeline/widgets/calender_strip.dart';
import 'package:etutor/features/timeline/widgets/timeline_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
    _fetchTimeline();
  }

  Future<void> _fetchTimeline() async {
    await context.read<SubcribedCourseProvider>().getTimeline(
          context: context,
          date: DateFormat('yyyy-MM-dd').format(selectedDate),
        );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SubcribedCourseProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar( 
        backgroundColor: AppColor.whiteColor,
        title: const Text(
          "Timeline",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 20.0),
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
              onDateSelected: (date) {
                setState(() => selectedDate = date);
                _fetchTimeline();
              },
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
              child: provider.isLoadingGetTLine
                  ? const Center(child: CircularProgressIndicator())
                  : (provider.getTLine?.data == null ||
                          provider.getTLine!.data!.isEmpty)
                      ? const Center(
                          child: Text("No activity found for this day."),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          itemCount: provider.getTLine!.data!.length,
                          itemBuilder: (context, index) {
                            final item = provider.getTLine!.data![index];

                            // Map type -> icon & color
                            IconData icon;
                            Color color;
                            switch (item.contentType?.toLowerCase()) {
                              case "videos":
                                icon = Icons.play_circle_fill;
                                color = Colors.deepOrange;
                                break;
                              case "test":
                                icon = Icons.format_list_bulleted;
                                color = Colors.blue;
                                break;
                              case "materials":
                                icon = Icons.description;
                                color = Colors.red;
                                break;
                              default:
                                icon = Icons.help_outline;
                                color = Colors.grey;
                            }

                            return TimelineItem(
                              icon: icon,
                              color: color,
                              title: item.contentName ?? "No Title",
                              subtitle: item.contentType ?? "",
                              time: item.time ?? "",
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
