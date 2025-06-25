import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:flutter/material.dart';

class GkPostScreen extends StatelessWidget {
  GkPostScreen({super.key});

  final List<String> posts = ["assets/images/gk1.png","assets/images/gk2.png","assets/images/gk3.png","assets/images/gk4.png","assets/images/gk5.png"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.secondaryColor ,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: Text(
          "Be Qurious",
          style: TextStyle(fontWeight: FontWeight.w500,),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomBackButton(),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(55)),
              border: Border(bottom:BorderSide(color: AppColor.primaryColor,width: 3) ),
            ),
            child: Center(
              child: Image.asset("assets/images/bequrious_logo.png",
              width: MediaQuery.of(context).size.width * 0.5,)),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                   alignment: WrapAlignment.start,
                   spacing: 8,
                   runSpacing: 8,
                   children: [
                   ...List.generate(
                    posts.length, 
                    (index) => SizedBox(
                      width:MediaQuery.of(context).size.width * .3, 
                      child: Image.asset(posts[index],fit: BoxFit.cover,)))
                   ],
                ),
              ),
            ),
          )
          
        ],
      ),
    );
  }
}