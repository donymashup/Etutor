import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/features/profile/screens/edit_profile.dart';
import 'package:etutor/features/profile/widgets/custom_wave_painter.dart';
import 'package:flutter/material.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          leading: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: CustomBackButton(),
          ),),
        body: SingleChildScrollView(
          child: Stack(
            children :[ CustomPaint(
              painter: CustomWavePainter(),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 120,
              ),
            ),
             Padding(
               padding: const EdgeInsets.all( 25.0,),
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 30.0,),
                     child: Row(
                     // crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        ClipRRect(
                          borderRadius:BorderRadius.circular(50),
                          child: Image.asset("assets/images/basil.jpg",
                          width:100 ,
                          height:100,
                          fit: BoxFit.cover,),),
                          SizedBox(width: 10,),
                         Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Basil Joseph",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                            Text("Class 6",style: TextStyle(color: AppColor.greyText,fontSize: 13),),
                          ],
                         ),
                         SizedBox(width: 30,),
                         IconButton(
                          onPressed: (){
                            Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                          }, 
                          icon: Icon(Icons.edit_note_rounded,size: 26,))
                       ],
                     ),
                   ),
                   SizedBox(height:40 ,),
                   Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                      Row(
                        children: [
                          Icon(Icons.person,color: AppColor.primaryColor,),
                          SizedBox(width: 20,),
                          Text("Basil Joseph",style: TextStyle(fontWeight: FontWeight.w600),)
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Icon(Icons.phone_android,color: AppColor.primaryColor,),
                          SizedBox(width: 20,),
                          Text("+91 8078559319",style: TextStyle(fontWeight: FontWeight.w600))
                        ],
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Icon(Icons.email,color: AppColor.primaryColor,),
                          SizedBox(width: 20,),
                          Text("josephBasil@gmail.com",style: TextStyle(fontWeight: FontWeight.w600))
                        ],
                      ),
                    SizedBox(height: 15,),
                      Row(
                        children: [
                          Icon(Icons.cake,color: AppColor.primaryColor,),
                          SizedBox(width: 20,),
                          Text("12/12/2012",style: TextStyle(fontWeight: FontWeight.w600))
                        ],
                      ),
                    SizedBox(height: 15,),
                      Row(
                        children: [
                          Icon(Icons.class_rounded,color: AppColor.primaryColor,),
                          SizedBox(width: 20,),
                          Text("6th Standard",style: TextStyle(fontWeight: FontWeight.w600))
                        ],
                      ),
                    SizedBox(height: 15,),
                    
                      Row(
                        children: [
                          Icon(Icons.school,color: AppColor.primaryColor,),
                          SizedBox(width: 20,),
                          Text("C.C.P.L.M School, Thevera",style: TextStyle(fontWeight: FontWeight.w600))
                        ],
                      ),
                     ],
                   ),
                   SizedBox(height: 30,),
                   Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColor.greyStroke)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child:ElevatedButton( 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                                )
                              ),                                
                              onPressed: (){}, 
                              child: Text("Delete Account",style: TextStyle(color: AppColor.whiteColor))),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child:ElevatedButton( 
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.secondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)
                                )
                              ),                                
                              onPressed: (){}, 
                              child: Text("Log out",style: TextStyle(color: AppColor.whiteColor),)),
                            ),
                          ),
                         
                        ],
                      ),
                    ),
                   )
          
                 ],
               ),
             )
            ],
          ),
        ),
      );

  }
}