import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';

class TestimonialCard extends StatefulWidget {
  String username;
  // IconData rating;
  String userimage;
  String description;
  
   TestimonialCard({
    required this.username,
    // required this.rating,
    required this.description,
    required this.userimage,
    super.key});

  @override
  State<TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<TestimonialCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColor.greyStroke),
            color: Colors.white),
        width: MediaQuery.of(context).size.width *.9,
       // height: MediaQuery.of(context).size.width *.34,
        child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 50,
                backgroundColor:AppColor.greyAppBar,
                backgroundImage: AssetImage(widget.userimage),
              ),
            )
            ,Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child:
                    //title and subtitle of the course
                    Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.username,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                    Row(
                      children: [
                       Icon(Icons.star,color: AppColor.fileIconColour,size: 18,),
                       Icon(Icons.star,color: AppColor.fileIconColour,size: 18,),
                       Icon(Icons.star,color: AppColor.fileIconColour,size: 18,),
                       Icon(Icons.star,color: AppColor.fileIconColour,size: 18,),
                       Icon(Icons.star,color: AppColor.fileIconColour,size: 18,),
                      ],
                    ),
                    Text(
                    widget.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
            ),
            //icon for moving to next page
            // IconButton(onPressed: widget.onPressed, icon: Icon(Icons.arrow_forward_ios))
          ],
        ),
      ),
    );
  }
}
