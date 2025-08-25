import 'package:etutor/features/live/provider/live_class_provider.dart';
import 'package:etutor/features/live/screens/recorded_months_screen.dart';
import 'package:etutor/features/live/widgets/recorded_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecordedYearsScreen extends StatefulWidget {
  const RecordedYearsScreen({super.key});

  @override
  State<RecordedYearsScreen> createState() => _RecordedYearsScreenState();
}

class _RecordedYearsScreenState extends State<RecordedYearsScreen> {
  LiveClassProvider completedLiveClassProvider = LiveClassProvider();

  @override
  void initState() {
    super.initState();
    getCompletedLiveClasses();
  }

  Future<void> getCompletedLiveClasses() async {
    final liveClassProvider = context.read<LiveClassProvider>();
    await liveClassProvider.fetchLiveClasses(context);
  }

  @override
  Widget build(BuildContext context) {
    completedLiveClassProvider = context.watch<LiveClassProvider>();
    return Scaffold(
      body: SafeArea(
          child: completedLiveClassProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                  padding: EdgeInsets.all(5),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount:
                      completedLiveClassProvider.completedLiveClasses.length,
                  itemBuilder: (context, index) {
                    final year =
                        completedLiveClassProvider.completedLiveClasses[index];
                    return RecordedCard(
                      label: year.name ?? "Year",
                      onPressed: () {
                        completedLiveClassProvider.setYear(year.name ?? "");

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RecordedMonthsScreen(),
                          ),
                        );
                      },
                    );
                  })),
    );
  }
}
