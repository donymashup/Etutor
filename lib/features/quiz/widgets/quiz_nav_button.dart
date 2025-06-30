import 'package:flutter/material.dart';

class QuizNavButton extends StatefulWidget {
  QuizNavButton({super.key, required this.onPressed, required this.label});
  final void Function()? onPressed;
  final String label;

  @override
  State<QuizNavButton> createState() => _QuizNavButtonState();
}

class _QuizNavButtonState extends State<QuizNavButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
