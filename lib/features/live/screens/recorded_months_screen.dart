import 'package:etutor/features/live/provider/live_class_provider.dart';
import 'package:etutor/features/live/screens/recorded_live_screen.dart';
import 'package:etutor/features/live/widgets/recorded_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordedMonthsScreen extends StatefulWidget {
  const RecordedMonthsScreen({super.key});

  @override
  State<RecordedMonthsScreen> createState() => _RecordedMonthsScreenState();
}

class _RecordedMonthsScreenState extends State<RecordedMonthsScreen> {
  LiveClassProvider completedLiveClassProvider = LiveClassProvider();

  @override
  Widget build(BuildContext context) {
    completedLiveClassProvider = context.watch<LiveClassProvider>();
    return Scaffold(
      body: SafeArea(
          child: GridView.builder(
              padding: EdgeInsets.all(5),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount:
                  (completedLiveClassProvider.completedLiveYear.months ?? [])
                      .length,
              itemBuilder: (context, index) {
                final month =
                    (completedLiveClassProvider.completedLiveYear.months ??
                        [])[index];
                return RecordedCard(
                  label: month.name ?? "Month",
                  onPressed: () {
                    completedLiveClassProvider.setMonth(month.name ?? "Month");

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const RecordedLiveScreen(),
                      ),
                    );
                  },
                );
              })),
    );
  }
}
