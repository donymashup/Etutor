import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class PaymentMethod extends StatefulWidget {
  PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  String? _selectedOption;

  final List<Map<String, String>> method = const [
    {
      "name": "Pay Pal",
      "icon": "assets/icons/paypal.png",
      "info": "09******7654321"
    },
    {
      "name": "GPay",
      "icon": "assets/icons/googlepay.png",
      "info": "qwert@okicicibank",
    },
    {
      "name": "Mastercard",
      "icon": "assets/icons/mastercard.png",
      "info": "065*****98765432123456",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.whiteColor,
        title: Text(
          "Choose payment method",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomBackButton(),
        ),
      ),
      body: SizedBox.expand(
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
                              onTap: () {},
                              child: Center(
                                  child: Text("+  Add New Payment Method"))),
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: method.length,
                            itemBuilder: (context, index) {
                              final methods = method[index];
                              return Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: _selectedOption == methods['name']
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
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color:
                                                        AppColor.greyStroke)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Image.asset(
                                                methods['icon']!,
                                                // width: 20,
                                                //  height: 20,
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
                                              Text(methods['name']!,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                methods['info']!,
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
                                        value: methods['name'],
                                        groupValue: _selectedOption,
                                        onChanged: (value) {
                                          setState(() {
                                            _selectedOption = value!;
                                          },  );
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
                        buttoncolor: _selectedOption == null ?AppColor.greyButton : AppColor.primaryColor,
                        textColor: AppColor.whiteColor),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
