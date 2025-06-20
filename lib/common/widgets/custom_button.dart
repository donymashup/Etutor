import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
void Function() onpressed;
Color color;
String text;
  CustomButton({
    super.key,
    required this.onpressed,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 45,
      child: ElevatedButton(
      onPressed:onpressed, 
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.primaryColor,
      ),
      child:Text(text,style: TextStyle(color: color,fontWeight: FontWeight.w600,fontSize: 15),),
       ),
    );
  }
}
