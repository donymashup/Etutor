import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoAssignments extends StatelessWidget {
  const NoAssignments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment:MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Lottie.asset(
                'assets/lottie/noAssignments.json',
                fit: BoxFit.cover,
                width: 500,
              ),
          Text("You have no assignments", 
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),)    
        ],
      ),
    );
  }
}