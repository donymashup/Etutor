import 'package:cached_network_image/cached_network_image.dart';
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

    // safe scroll after first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      } catch (_) {
        // ignore if not scrollable yet
      }
      _fetchTimeline();
    });
  }

  Future<void> _fetchTimeline() async {
    await context.read<SubcribedCourseProvider>().getTimeline(
          context: context,
          date: DateFormat('yyyy-MM-dd').format(selectedDate),
        );
  }

  /// Converts incoming server time (assumed UTC if no timezone present)
  /// to IST and returns a formatted string like "02:30 PM".
  String formatToIST(String? timeString) {
    if (timeString == null || timeString.trim().isEmpty) return "";

    try {
      var s = timeString.trim();

      // Normalize common variant with space between date and time -> use 'T' so parse works with appended 'Z'
      s = s.replaceAll(' ', 'T');

      // Check if the string already has a timezone designator (Z or +/-HH:MM)
      final tzAware = RegExp(r'(Z|[+-]\d{2}:\d{2})$').hasMatch(s);

      // If there's no timezone info, assume the incoming time is UTC and append 'Z'
      if (!tzAware) s = s + 'Z';

      // Parse and convert to UTC, then add IST offset (+5:30)
      final parsedUtc = DateTime.parse(s).toUtc();
      final ist = parsedUtc.add(const Duration(hours: 5, minutes: 30));

      // Format (you can change pattern if you want date + time)
      return DateFormat('hh:mm a').format(ist);
    } catch (e) {
      debugPrint('formatToIST parse error: $e');
      // fallback to raw string if parsing fails
      return timeString;
    }
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
                                color = Colors.blue;
                                break;
                              case "test":
                                icon = Icons.format_list_bulleted;
                                color = Colors.green;
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
                              // convert server time -> IST for display
                              time: formatToIST(item.time),
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
