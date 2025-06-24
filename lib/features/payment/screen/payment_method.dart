import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatelessWidget {
 PaymentMethod({super.key});

final List<Map<String, String>> method = [
  {
    "name":"Pay Pal",
    "icon":"",
  },
   {
    "name":"UPI",
    "icon":"",
  },
   {
    "name":"",
    "icon":"",
  }
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        centerTitle: true,
        backgroundColor: AppColor.whiteColor,
        title: Text("Choose payment method",style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
        leading: Padding(
         padding: const EdgeInsets.all(10.0),
         child: CustomBackButton(),
       ),
      ) ,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
             children: [
              Container(
                width: MediaQuery.of(context).size.width,
                 decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                 ),
                 child: Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColor.primaryColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: GestureDetector(
                      onTap: () { },
                      child: Center(child: Text("+  Add New Payment Method"))
                      ),
                  ),
                 ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text("xchjhkl,mnb")
                    ],
                  ),
                ),
              )
             ],
        ),
      ) ,
    );
  }
}