import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColor.greyBackground,
      appBar: AppBar(
        backgroundColor: AppColor.whiteColor,
        title: Center(
            child: Text(
          "Buy Course",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        
        ),
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.whiteColor,
                  ),
                  child: Column(
                    children: [
          
                      //course details card
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset("assets/icons/clipIcon.png"),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Detail Course"),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/images/course1.png",
                                  width: MediaQuery.of(context).size.width * .3,
                                )),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                                child: Text(
                              "Class 06 Foundation 25-26",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            )),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          color: AppColor.greyStroke,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                                style: TextStyle(fontFamily: "Poppins"),
                                children: [
                                  TextSpan(
                                      text: "Price Course ",
                                      style: TextStyle(
                                          color: AppColor.greyText,
                                          fontSize: 13)),
                                  TextSpan(
                                      text: "₹10000",
                                      style: TextStyle(
                                          color: AppColor.primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500)),
                                ]),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )),
          
              //voucher card
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.whiteColor,
                ),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("assets/icons/clipIcon.png"),
                        SizedBox(
                          width: 5,
                        ),
                        Text("voucher"),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: AppColor.fileIconColour,
                                    ),
                                    child: Icon(
                                      Icons.discount_outlined,
                                      color: AppColor.whiteColor,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      "Select Voucher or Promo Code",
                                      maxLines: 2,
                                      style: TextStyle(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios_outlined),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
          
              //payment method card
               Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.whiteColor,
                ),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("assets/icons/clipIcon.png"),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Payment Method"),
                      ],
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColor.imageIconColour,
                                  ),
                                  child: Icon(
                                    Icons.payment_outlined,
                                    color: AppColor.whiteColor,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Choose Payment Method",
                                  style: TextStyle(),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_ios_outlined),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              
              //bill splits card
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                         Image.asset("assets/icons/clipIcon.png"),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Summary"),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Text("PricePrice",style: TextStyle(fontSize:13 ,color:AppColor.greyTextDark ),),
                         Text("₹1000")
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Text("Voucher Discount",style: TextStyle(fontSize:13 ,color:AppColor.greyTextDark ),),
                         Row(
                           children: [
                            Text("-"),
                             Text("₹0"),
                           ],
                         )
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Text("Tax",style: TextStyle(fontSize:13 ,color:AppColor.greyTextDark ),),
                         Row(
                           children: [
                             Text("-"),
                             Text("₹0"),
                           ],
                         )
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(color: AppColor.greyStroke,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         Text("Total Amount",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                         Text("₹10000",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                      ],),
                    ),
                   
                  ],
                ),
              ),
               Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: CustomButton(
                        onpressed: (){}, 
                        text: "Pay  ₹10000" , 
                        buttoncolor: AppColor.greyButton, 
                        textColor: AppColor.whiteColor),
                    )
            ],
          ),
        ),
      ),
    ));
  }
}
