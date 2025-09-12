import 'package:cached_network_image/cached_network_image.dart';
import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:etutor/features/my_course/screens/my_course.dart';
import 'package:etutor/features/payment/controller/payment_provider.dart';
import 'package:etutor/features/payment/screen/voucher_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutScreen extends StatefulWidget {
  final String image;
  final String name;
  final String price;
  final String courseId;
  CheckoutScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.courseId});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    final paymentProvider = context.read<PaymentProvider>();
    paymentProvider.setTotalAmt(widget.price);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentProvider = context.watch<PaymentProvider>();
    final selectedVoucher = paymentProvider.selectedVoucher;
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
      body: paymentProvider.isVerifying
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SizedBox.expand(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: widget.image,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .3,
                                            fit: BoxFit
                                                .cover, // Adjust as needed
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .3,
                                                height: 150,
                                                color: Colors.white,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .3,
                                              height: 150,
                                              color: Colors.grey[300],
                                              child: Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            widget.name,
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: RichText(
                                        text: TextSpan(
                                          style:
                                              TextStyle(fontFamily: "Poppins"),
                                          children: [
                                            TextSpan(
                                              text: "Price Course ",
                                              style: TextStyle(
                                                  color: AppColor.greyText,
                                                  fontSize: 13),
                                            ),
                                            TextSpan(
                                              text: "₹ ${widget.price}",
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
                            GestureDetector(
                              onTap: () {
                                selectedVoucher != null
                                    ? context
                                        .read<PaymentProvider>()
                                        .clearVoucher(widget.price)
                                    : Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => VoucherScreen(
                                                  courseId: widget.courseId,
                                                )),
                                      );
                              },
                              child: Container(
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                            "assets/icons/clipIcon.png"),
                                        SizedBox(width: 5),
                                        Text("Voucher"),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color:
                                                        AppColor.fileIconColour,
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
                                                      color: selectedVoucher !=
                                                              null
                                                          ? AppColor
                                                              .primaryColor
                                                          : Colors.black,
                                                      fontWeight:
                                                          selectedVoucher !=
                                                                  null
                                                              ? FontWeight.w500
                                                              : FontWeight
                                                                  .normal,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          selectedVoucher != null
                                              ? Text(
                                                  "remove",
                                                  style: TextStyle(
                                                      color:
                                                          AppColor.primaryColor,
                                                      fontSize: 13),
                                                )
                                              : Icon(Icons
                                                  .arrow_forward_ios_outlined),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Price (incl. all tax)",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: AppColor.greyTextDark),
                                        ),
                                        Text(" ₹ ${widget.price}")
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Amount",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          " ₹ ${paymentProvider.total}",
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
                                        color: AppColor.secondaryColor,
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
                                onpressed: () async {
                                  if (widget.price == "0" ||
                                      paymentProvider.total == "0") {
                                    final freeEnrollSuccess = await context
                                        .read<PaymentProvider>()
                                        .freeEnrollStudent(
                                          context: context,
                                          courseid: widget.courseId,
                                          promo:
                                              paymentProvider.selectedVoucher ??
                                                  "",
                                          amount: "0",
                                        );

                                    if (freeEnrollSuccess) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyCoursePage()),
                                        (route) =>
                                            false, // remove previous routes
                                      );
                                    }
                                  } else {
                                    // ✅ Normal payment flow
                                    // Example: navigate to your payment method page
                                    // Navigator.push(context, MaterialPageRoute(
                                    //   builder: (context) => PaymentMethod(
                                    //     price: paymentProvider.total!,
                                    //     courseId: widget.courseId,
                                    //     promo: paymentProvider.selectedVoucher ?? "",
                                    //     courseName: widget.name,
                                    //   ),
                                    // ));
                                  }
                                },
                                text: (widget.price == "0" ||
                                        paymentProvider.total == "0")
                                    ? "Enroll Free Course"
                                    : "Pay ₹ ${paymentProvider.total}",
                                buttoncolor: AppColor.primaryColor,
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
