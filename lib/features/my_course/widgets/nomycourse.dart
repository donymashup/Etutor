import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class nomycourse extends StatelessWidget {
  const nomycourse({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment:MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Lottie.asset(
                'assets/lottie/nomycourse.json',
                fit: BoxFit.cover,
                width: 300,
              ),
          Text("You are not enrolled in any courses", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),)    
        ],
      ),
    );
  }
}