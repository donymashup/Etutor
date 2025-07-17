import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ParabolaShaphedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColor.secondaryColorLight;

    final path = Path();
    path.moveTo(0, size.height );

    // First upward wave
    path.quadraticBezierTo(      
      size.width * 0.5, size.height*.7,  
      size.width, size.height, 
    );
    
    // Close shape to top 
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
