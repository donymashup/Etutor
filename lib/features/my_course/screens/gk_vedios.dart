import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:flutter/material.dart';

class GkVedios extends StatelessWidget {
GkVedios({super.key});

 final List<Map<String,String>> _videos =[
  {
   'title' :"Foundation Class 25-26 forstudents from class 6 - 7 foundation",
   'img':"assets/images/course1.png",
   'duration':"1hr 30mins",
  },
   {
   'title' :"Foundation Class 25-26 forstudents from class 6 - 7 foundation",
   'img':"assets/images/course2.png",
   'duration':"1hr 30mins",
  },
   {
   'title' :"Foundation Class 25-26 forstudents from class 6 - 7 foundation",
   'img':"assets/images/course3.png",
   'duration':"1hr 00mins",
  },
 ]; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColor.secondaryColor ,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: Text(
          "Be Qurious",
          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomBackButton(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            Column(
              children: List.generate(
              _videos.length,
                (index) {
                  final video =_videos[index];
                  return VideooCard(
                    title: video['title']!,
                    img: video['img']!,
                    duration: video['duration']!,
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//card for gk video
class VideooCard extends StatelessWidget {
  String title;
  String img;
  String duration;
  VideooCard({
    super.key,
    required this.duration,
    required this.img,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
             decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(10),
            border: Border.all(color: AppColor.lightNightBlue),
            color: AppColor.greyCardBackground,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width *0.25,
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
    children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.secondaryColor),
            image: DecorationImage(image: AssetImage(img),fit: BoxFit.cover,
          ),),
          height: MediaQuery.of(context).size.width *0.25,
          width: MediaQuery.of(context).size.width * 0.39,
        ),
          SizedBox(width: 5,),
          Expanded(
            child:SizedBox(
           height: MediaQuery.of(context).size.width *0.27,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16),),                    
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Duration",style: TextStyle(color: AppColor.greyText,fontSize: 13),),
                      SizedBox(width: 5,),
                      Expanded(child: Text(duration,style: TextStyle(fontSize: 13),)),
                      Icon(Icons.play_circle_fill_outlined ,color: AppColor.primaryColor,size: 24,)
                    ],
                  )
                ],
              ),
            ),
          )
    ],
            ),
          ),
        );
  }
}