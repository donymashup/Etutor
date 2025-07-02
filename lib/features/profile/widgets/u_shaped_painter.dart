import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class UShapedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColor.primaryColor;

    final path = Path();
    path.moveTo(0, size.height *.55 );

    // First upward wave
    path.quadraticBezierTo(      
      size.width * 0.5, size.height,  
      size.width, size.height * .5, 
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
