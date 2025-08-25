import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class RecordedCard extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  const RecordedCard({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Card(
          color: AppColor.lighBlueBackground,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.folder,
                size: MediaQuery.of(context).size.width * 0.2,
                color: AppColor.fileIconColour,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                label,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
