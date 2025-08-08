import 'package:flutter/material.dart';

//widget for lable of the textfield
class Label extends StatelessWidget {
  final String labelText;
  const Label({
    super.key,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("*", style: TextStyle(color: Colors.red)),
        const SizedBox(width: 5),
        Text(labelText),
      ],
    );
  }
}