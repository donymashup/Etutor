import 'package:etutor/features/live/widgets/live_card.dart';
import 'package:flutter/material.dart';

class RecordedLiveScreen extends StatelessWidget {
  const RecordedLiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Column(
        children: [
          LiveCard(img:"assets/images/course1.png",time: "09.00 AM",date: "12 may 2025",title: "Foundation Class 25-26 for students from class 6 - 7 foundation",),
          LiveCard(img:"assets/images/course2.png",time: "10.00 Am",date: "10 may 2025",title: "Foundation Class 25-26 for students from class 6 - 7 foundation"),
        ],
      )
    );
  }
}