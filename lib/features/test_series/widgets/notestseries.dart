import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class noTestSeries extends StatelessWidget {
  const noTestSeries({
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
                'assets/lottie/notestseries.json',
                fit: BoxFit.cover,
                width: 300,
              ),
          Text("No test series are available right now Check back soon for updates", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),)    
        ],
      ),
    );
  }
}