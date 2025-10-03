import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:etutor/features/live/provider/live_class_provider.dart';
import 'package:etutor/features/live/screens/recorded_live_screen.dart';
import 'package:etutor/features/live/widgets/recorded_card.dart';
import 'package:provider/provider.dart';

class RecordedMonthsScreen extends StatefulWidget {
  final String year;
  const RecordedMonthsScreen({super.key, required this.year});

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
        child: Column(
          children: [
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Transform.scale(
                    scale: 0.8, 
                    child: CupertinoNavigationBarBackButton(
                      color: Colors.black,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.year, 
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount:
                    (completedLiveClassProvider.completedLiveYear.months ?? [])
                        .length,
                itemBuilder: (context, index) {
                  final month = (completedLiveClassProvider
                          .completedLiveYear.months ??
                      [])[index];
                  return RecordedCard(
                    label: month.name ?? "Month",
                    onPressed: () {
                      completedLiveClassProvider
                          .setMonth(month.name ?? "Month");

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>  RecordedLiveScreen(month: month.name ?? 'Month'),
                        ),
                      );
                    },
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
