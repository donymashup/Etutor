import 'package:etutor/common/widgets/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etutor/common/constants/app_constants.dart';

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final String dateGroup;
  final IconData icon;
  final String? imagePath;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.dateGroup,
    required this.icon,
    this.imagePath,
  });
}

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  List<NotificationItem> get notifications => [
        NotificationItem(
          title: 'New update is available',
          message: 'Dear user, etutor android app has got a new update',
          time: '8.00 am',
          dateGroup: 'Today',
          icon: Icons.notifications_none,
        ),
        NotificationItem(
          title: 'Course Completed',
          message: 'Congrats! You completed Python Basics course.',
          time: '9.45 am',
          dateGroup: 'Today',
          icon: Icons.school_outlined,
          imagePath: 'assets/images/course1.png',
        ),
        NotificationItem(
          title: 'Exam Reminder',
          message: 'Your JEE mock test starts in 30 minutes.',
          time: '10.30 am',
          dateGroup: 'Today',
          icon: Icons.timer_outlined,
        ),
        NotificationItem(
          title: 'Daily Practice',
          message: 'Your new daily challenge is ready!',
          time: '6.00 am',
          dateGroup: 'Today',
          icon: Icons.assignment_outlined,
          imagePath: 'assets/images/course2.png',
        ),
        NotificationItem(
          title: 'Payment Successful',
          message: 'Your subscription has been renewed successfully.',
          time: '5.00 pm',
          dateGroup: 'Yesterday',
          icon: Icons.payment,
        ),
        NotificationItem(
          title: 'New Course Available',
          message: 'Explore the new Data Structures course.',
          time: '4.00 pm',
          dateGroup: 'Yesterday',
          icon: Icons.book_outlined,
        ),
      ];

  Widget _buildNotificationTile(NotificationItem item, BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, color: Colors.blue),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (item.imagePath != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item.imagePath!,
                      height: MediaQuery.of(context).size.width * 0.45,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Text(
                item.title,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(item.message, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 4),
              Text(item.time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
        const Divider(indent: 70, endIndent: 16),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todayItems = notifications.where((e) => e.dateGroup == 'Today').toList();
    final yesterdayItems = notifications.where((e) => e.dateGroup == 'Yesterday').toList();

    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title:  Text(
              "Notifications",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: CustomBackButton(),
        ),
     ),
      body: SafeArea(
        child: ListView(
          children: [
            if (todayItems.isNotEmpty) _buildSectionHeader('Today'),
            ...todayItems.map((item) => _buildNotificationTile(item, context)),
            if (yesterdayItems.isNotEmpty) _buildSectionHeader('Yesterday'),
            ...yesterdayItems.map((item) => _buildNotificationTile(item, context)),
          ],
        ),
      ),
    );
  }
}
