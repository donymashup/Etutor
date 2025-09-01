import 'package:etutor/common/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavBarScreen())), child: Text("Next")),),
    );
  }
}