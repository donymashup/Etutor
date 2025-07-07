import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class NoVoucherCard extends StatelessWidget {
  final String text;
  const NoVoucherCard({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
     child:  Padding(
       padding: const EdgeInsets.all(15.0),
       child: Container(
        width: MediaQuery.of(context).size.width,
       // height:MediaQuery.of(context).size.width * .5, 
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColor.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Container(
                  height: 60,
                  width:60,
                decoration: BoxDecoration(
                  color: AppColor.greyCardBackground,
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Iconify( Mdi.coupon_outline,color: AppColor.primaryColor,size: 20,),
                )),
                Text(text,style:TextStyle(fontWeight:FontWeight.w600 ,fontSize: 18),),
                //Text("Try to apply promo code",style:TextStyle(fontWeight:FontWeight.w400 ,fontSize: 13))
            ],
          ),
        ),
       ),
     )
    );
  }
}
