import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class noLiveClass extends StatelessWidget {
  const noLiveClass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center ,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Lottie.asset(
                  'assets/lottie/noLiveClass.json',
                  fit: BoxFit.cover,
                  width: 300,
                ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("No live classes are available right now Check back soon for updates", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),
            )    
          ],
        ),
      ),
    );
  }
}