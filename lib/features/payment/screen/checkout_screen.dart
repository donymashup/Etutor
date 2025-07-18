import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:etutor/features/payment/controller/payment_provider.dart';
import 'package:etutor/features/payment/screen/payment_method.dart';
import 'package:etutor/features/payment/screen/payment_succesfull.dart';
import 'package:etutor/features/payment/screen/voucher_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selected = context.watch<PaymentProvider>().selectedPayment;
    final selectedVoucher = context.watch<PaymentProvider>().selectedVoucher;
    bool isCoinApplied = false;
    return Scaffold(
      backgroundColor: AppColor.greyBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.whiteColor,
        title: Text(
          "Buy Course",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomBackButton(),
        ),
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // Course card
              Expanded(
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
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset("assets/icons/clipIcon.png"),
                                SizedBox(width: 5),
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
                                      width:
                                          MediaQuery.of(context).size.width * .3,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      "Class 06 Foundation 25-26",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(color: AppColor.greyStroke),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
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
                                            fontSize: 13),
                                      ),
                                      TextSpan(
                                        text: "₹10000",
                                        style: TextStyle(
                                            color: AppColor.primaryColor,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10)
                          ],
                        ),
                      ),
                            
                      // Voucher card
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selectedVoucher != null
                              ? AppColor.lighBlueBackground
                              : AppColor.whiteColor,
                          border: selectedVoucher != null
                              ? Border.all(color: AppColor.primaryColor)
                              : null,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset("assets/icons/clipIcon.png"),
                                SizedBox(width: 5),
                                Text("Voucher"),
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
                                            borderRadius:
                                                BorderRadius.circular(5),
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
                                            selectedVoucher ??
                                                "Select Voucher or Promo Code",
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: selectedVoucher != null
                                                  ? AppColor.primaryColor
                                                  : Colors.black,
                                              fontWeight: selectedVoucher != null
                                                  ? FontWeight.w500
                                                  : FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  selectedVoucher != null
                                      ? TextButton(
                                          onPressed: () => context
                                              .read<PaymentProvider>()
                                              .clearVoucher(),
                                          child: Text(
                                            "remove",
                                            style: TextStyle(
                                                color: AppColor.primaryColor,
                                                fontSize: 13),
                                          ))
                                      : IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      VoucherScreen()),
                                            );
                                          },
                                          icon: Icon(
                                              Icons.arrow_forward_ios_outlined),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                            
                      // Payment method card
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: selected != null
                              ? AppColor.lighBlueBackground
                              : AppColor.whiteColor,
                          border: selected != null
                              ? Border.all(color: AppColor.primaryColor)
                              : null,
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset("assets/icons/clipIcon.png"),
                                SizedBox(width: 5),
                                Text("Payment Method"),
                              ],
                            ),
                            selected == null
                                ? Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: AppColor.imageIconColour,
                                              ),
                                              child: Icon(
                                                Icons.payment_outlined,
                                                color: AppColor.whiteColor,
                                                size: 20,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text("Choose Payment Method"),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentMethod(),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                              Icons.arrow_forward_ios_outlined),
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Row(
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
                                                    selected['icon']!,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Flexible(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(selected['name']!),
                                                    Text(
                                                      selected['info']!,
                                                      style: TextStyle(
                                                          color:
                                                              AppColor.greyText),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentMethod(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "change",
                                            style: TextStyle(
                                                color: AppColor.primaryColor),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      ),
                            
                      // Summary
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Image.asset("assets/icons/clipIcon.png"),
                                SizedBox(width: 5),
                                Text("Summary"),
                              ],
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Price (incl. all tax)",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColor.greyTextDark),
                                  ),
                                  Text("₹10000")
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Voucher Discount",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColor.greyTextDark),
                                  ),
                                  Row(
                                    children: [
                                      Text("- "),
                                      Text(selectedVoucher ?? "₹0"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Divider(color: AppColor.greyStroke),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Amount",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "₹10000",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          
              StatefulBuilder(
                builder: (context, setState) => Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0, bottom: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Checkbox with label
                        Row(
                          children: [
                            Checkbox(
                              value: isCoinApplied,
                              activeColor: AppColor.primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  isCoinApplied = value!;
                                });
                              },
                            ),
                            const SizedBox(width: 8),
                            Row(
                              children: [
                                const Text(
                                  "Apply ",
                                  style: TextStyle(fontSize: 14),
                                ),
                                Icon(
                                  Icons.monetization_on,
                                  size: 14,
                                  color: AppColor
                                      .secondaryColor, 
                                ),
                                const Text(
                                  "125 Dream Coin",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Confirm button
                        CustomButton(
                          onpressed: () {
                            if (selected != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PaymentSuccesfull()),
                              );
                            }
                          },
                          text:
                              "Pay  ₹10000", 
                          buttoncolor: selected != null
                              ? AppColor.primaryColor
                              : AppColor.greyButton,
                          textColor: AppColor.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
