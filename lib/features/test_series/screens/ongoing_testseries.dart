import 'package:flutter/material.dart';

class OngoingPage extends StatelessWidget {
  const OngoingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ongoing')),
      body: const Center(child: Text('Ongoing content')),
    );
  }
}