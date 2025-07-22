import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onpressed;
  final Color buttoncolor;
  final String text;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.onpressed,
    required this.text,
    required this.buttoncolor,
    required this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: buttoncolor,
        ),
        child: Text(
          text,
          style:
              TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
    );
  }
}
