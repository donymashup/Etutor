import 'package:flutter/material.dart';

class UpcomingPage extends StatelessWidget {
  const UpcomingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upcoming')),
      body: const Center(child: Text('Upcoming content')),
    );
  }
}
