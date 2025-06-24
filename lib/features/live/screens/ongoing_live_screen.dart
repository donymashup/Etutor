import 'package:etutor/features/live/widgets/live_card.dart';
import 'package:flutter/material.dart';

class OngoingLiveScreen extends StatelessWidget {
  const OngoingLiveScreen({super.key});

   final List<Map<String, dynamic>> liveClass = const [
    {
      'img':"assets/images/course1.png",
      "time": "09.00 AM",
      'date': "12 may 2025",
      'title': "Foundation Class 25-26 for students from class 6 - 7 foundation",
    },
    {
      'img':"assets/images/course2.png",
      'time': "10.00 Am",
      'date': "10 may 2025",
      'title': "Foundation Class 25-26 for students from class 6 - 7 foundation"
    },
    {
      'img':"assets/images/course3.png",
      'time': "12.00 Am",
      'date': "10 may 2025",
      'title': "Foundation Class 25-26 for students from class 6 - 7 foundation"
    }

  ];

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: ListView.builder(
        itemCount: liveClass.length,
        itemBuilder: (context, index){ 
          final live =liveClass[index];
        return Column(
          children: [
            LiveCard(
              img: live['img'],
              time: live['time'],
              date: live['date'],
              title:live['title'],
            ),
          ],
        );
        }
      )
    );
  }
}

