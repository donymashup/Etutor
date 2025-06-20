import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class LiveCard extends StatelessWidget {
  String img;
  String title;
  String date;
  String time;
   LiveCard({
    super.key,
    required this.date,
    required this.img,
    required this.time,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        border: Border.all(color: AppColor.primaryColor),
        color: AppColor.greyCardBackground,
      ),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.secondaryColor),
                  image: DecorationImage(image: AssetImage(img),fit: BoxFit.cover,
                ),),
                height: MediaQuery.of(context).size.width *0.3,
                width: MediaQuery.of(context).size.width * 0.39,
              ),
                SizedBox(width: 5,),
                Expanded(
                  child:SizedBox(
                 height: MediaQuery.of(context).size.width *0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),                    
                        Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         crossAxisAlignment: CrossAxisAlignment.end,
                           children: [
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("Date"),
                                 Text(date),
                               ],
                             ),                            
                             Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text("Time"),
                                 Text(time),
                               ],
                             )                
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