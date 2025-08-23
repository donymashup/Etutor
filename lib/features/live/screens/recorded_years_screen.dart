import 'package:etutor/features/live/widgets/recorded_card.dart';
import 'package:flutter/material.dart';

class RecordedYearsScreen extends StatefulWidget {
  const RecordedYearsScreen({super.key});

  @override
  State<RecordedYearsScreen> createState() => _RecordedYearsScreenState();
}

class _RecordedYearsScreenState extends State<RecordedYearsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: 5,
                
                itemBuilder: (context, index) => RecordedCard(label: "2025")),
          )
        ],
      )),
    );
  }
}
