import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class QuizCompletionScreen extends StatelessWidget {
  const QuizCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //lottie
                    Lottie.asset('assets/lottie/succesful_lottie.json',width: MediaQuery.of(context).size.width * 1.8,),
                    Text("Quiz Completed !",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w600),),
                    SizedBox(height: 15,),
                        
                    //questions info card
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.primaryColor)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                        
                            //attended question card
                            Column(
                              children: [
                                Text("Attended",style: TextStyle(fontSize: 13,color:AppColor.greyText ,fontWeight: FontWeight.w300),),
                                Text("25",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                                Text("Questions",style: TextStyle(fontSize: 16),),
                              ],
                            ),
                        
                            //unattended question card
                            Column(
                              children: [
                                Text("Unattended",style: TextStyle(fontSize: 13,color:AppColor.greyText ,fontWeight: FontWeight.w300),),
                                Text("5",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                                Text("Questions",style: TextStyle(fontSize: 16),),
                              ],
                            ),
                        
                            //total question card
                            Column(
                              children: [
                                Text("Total",style: TextStyle(fontSize: 13,color:AppColor.greyText ,fontWeight: FontWeight.w300),),
                                Text("30",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                                Text("Questions",style: TextStyle(fontSize: 16),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                        
                    //correct and wrong answers card
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        children: [
                        
                          //correct answer card
                           Expanded(
                             child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColor.greenStroke )
                              ),
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Column(
                                  children: [
                                   Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                                     
                                        // check icon wirh green circle bg
                                        Container(
                                           width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: const Color.fromARGB(194, 110, 238, 84),
                                          ),
                                          child: Icon(Icons.check_outlined,color: AppColor.whiteColor,size: 18,)),
                                          SizedBox(width: 10,),
                                          Text("Correct",style: TextStyle(color:AppColor.greenStroke ,fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                    Text("15",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                                    Text("Questions",style: TextStyle(fontSize: 16),),
                                  ],
                                 ),
                               ),
                             ),
                           ),
                            SizedBox(width: 10,),
                        
                            //wrong answer card
                            Expanded(
                              child: Container(
                               decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColor.redStroke )
                              ),
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                                      
                                        //wrong icon with red circle bg
                                        Container(
                                            width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: const Color.fromARGB(176, 254, 124, 126) ,
                                          ),
                                          
                                          child: Icon(Icons.clear,color:  AppColor.redStroke ,size: 18,)),
                                          SizedBox(width: 10,),
                                        Text("Wrong",style: TextStyle(color:AppColor.redStroke ,fontWeight: FontWeight.w600),),
                                      ],
                                    ),
                                    Text("10",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                                    Text("Questions",style: TextStyle(fontSize: 16),),
                                  ],
                                 ),
                               ),
                                                         ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 50,),
                
                    //custom blue button
                    CustomButton(onpressed: (){}, text: "Review Answers", buttoncolor: AppColor.primaryColor, textColor: AppColor.whiteColor),
                    SizedBox(height: 5,),
                    //textbutton
                    TextButton(
                      onPressed: (){}, 
                      child: Text("Go Back To Home",
                      style: TextStyle(
                        color: AppColor.secondaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.red,
                        ),))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}