import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:etutor/features/payment/widgets/no_vouchers.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';

class VoucherScreen extends StatefulWidget {
  VoucherScreen({super.key});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  String? _selectedOption;

  List<Map<String, String>> promo = [
    {
      "discount": "Discount  ₹500",
      "valid": "Valid until 05 Jun 2025  ",
    },
    {
      "discount": "Discount 50%",
      "valid": "Valid until 05 Jun 2025  ",
    },
    {
      "discount": "Discount  10%",
      "valid": "Valid until 05 Jun 2025  ",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.whiteColor,
        title: Expanded(
          child: Text(
            "Apply voucher or Promo code",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomBackButton(),
        ),
      ),
      body: promo.isEmpty ?  NoVoucherCard()
      :
      SizedBox.expand(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Apply Promo Code",
                                    hintStyle:
                                        TextStyle(color: AppColor.greyText,fontSize: 13),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: AppColor.primaryColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: AppColor.primaryColor)),
                                    prefixIcon: Icon(Icons.discount_outlined,color: AppColor.greyIcon,size: 15,),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                height: 45,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primaryColor,
                                    // padding: EdgeInsets.symmetric(horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text("Apply",
                                      style: TextStyle(
                                          color: AppColor.whiteColor)),
                                ),
                              ),
                            ],
                          ),
                        )
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset("assets/icons/clipIcon.png"),
                                SizedBox(width: 5,),
                                Text("Voucher Available for you",style: TextStyle(color: AppColor.primaryColor,fontSize: 13),),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: promo.length,
                                itemBuilder: (context, index) {
                                  final promos = promo[index];
                                  return Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: _selectedOption == promos['discount']
                                            ? Border.all(
                                                color: AppColor.primaryColor)
                                            : Border.all(
                                                color: AppColor.greyStroke)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                
                                                decoration: BoxDecoration(
                                                  color: AppColor.fileIconColour, 
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Iconify( Mdi.coupon_outline,
                                                    color: AppColor.whiteColor,
                                                    
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(promos['discount']!,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    promos['valid']!,
                                                    style: TextStyle(
                                                        color: AppColor.greyText,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Radio(
                                            value: promos['discount'],
                                            groupValue: _selectedOption,
                                            onChanged: (value) {
                                              setState(
                                                () {
                                                  _selectedOption = value!;
                                                },
                                              );
                                            },
                                            activeColor: AppColor.primaryColor,
                                            visualDensity: VisualDensity.compact,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.bottomCenter,
                  color: AppColor.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0, bottom: 20),
                    child: CustomButton(
                        onpressed: () {},
                        text: "Confirm",
                        buttoncolor: _selectedOption == null
                            ? AppColor.greyButton
                            : AppColor.primaryColor,
                        textColor: AppColor.whiteColor),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

