import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:etutor/features/payment/controller/payment_provider.dart';
import 'package:etutor/features/payment/widgets/no_vouchers.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:provider/provider.dart';

class VoucherScreen extends StatefulWidget {
  final String courseId;
  const VoucherScreen({super.key,required this.courseId});

  @override
  State<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PaymentProvider>(context, listen: false);
     provider.getPromoCode(context);
     });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.whiteColor,
        title: Text(
          "Apply voucher or Promo code",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomBackButton(),
        ),
      ),
      body: Consumer<PaymentProvider>(
        builder: (context, paymentProvider, child) {
          if (paymentProvider.ispromoLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (paymentProvider.promocodes.isEmpty) {
            return NoVoucherCard(text: "Sorry, you don't have voucher");
          }

          return SizedBox.expand(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Search field
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: _searchController,
                              onChanged: (query) {
                                paymentProvider.filterPromoCodes(query);
                              },
                              decoration: InputDecoration(
                                hintText: "Apply Promo Code",
                                hintStyle: TextStyle(
                                    color: AppColor.greyText, fontSize: 13),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: AppColor.primaryColor)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                        color: AppColor.primaryColor)),
                                prefixIcon: Icon(
                                  Icons.discount_outlined,
                                  color: AppColor.greyIcon,
                                  size: 15,
                                ),
                                suffixIcon: paymentProvider.searchQuery.isNotEmpty
                                    ? IconButton(
                                        icon: Icon(Icons.clear,
                                            color: AppColor.greyIcon, size: 18),
                                        onPressed: () {
                                          _searchController.clear();
                                          paymentProvider.clearFilter();
                                        },
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),

                        // Promo codes list
                        paymentProvider.filteredPromocodes.isEmpty
                            ? Padding(
                                padding: const EdgeInsets.symmetric(vertical: 50.0),
                                child: NoVoucherCard(
                                  text: paymentProvider.searchQuery.isNotEmpty
                                      ? "No matching promo found"
                                      : "No vouchers available",
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.whiteColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Image.asset("assets/icons/clipIcon.png"),
                                            SizedBox(width: 5),
                                            Text(
                                              "Voucher Available for you",
                                              style: TextStyle(
                                                  color: AppColor.primaryColor,
                                                  fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: AppColor.whiteColor,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: paymentProvider
                                              .filteredPromocodes.length,
                                          itemBuilder: (context, index) {
                                            final promo = paymentProvider
                                                .filteredPromocodes[index];
                                            return GestureDetector(
                                              onTap: () {
                                                paymentProvider.setVoucher(promo.code!);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: paymentProvider
                                                              .selectedVoucher ==
                                                          promo.code
                                                      ? Border.all(
                                                          color: AppColor
                                                              .primaryColor,
                                                          width: 2)
                                                      : Border.all(
                                                          color:
                                                              AppColor.greyStroke),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 40,
                                                            height: 40,
                                                            decoration: BoxDecoration(
                                                              color: AppColor
                                                                  .fileIconColour,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(20),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
                                                              child: Iconify(
                                                                Mdi.coupon_outline,
                                                                color: AppColor
                                                                    .whiteColor,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                promo.code ?? '',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                              SizedBox(height: 5),
                                                              Text(
                                                                promo.expiry ?? '',
                                                                style: TextStyle(
                                                                  color: AppColor
                                                                      .greyText,
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w300,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      Radio(
                                                        value: promo.code,
                                                        groupValue: paymentProvider
                                                            .selectedVoucher,
                                                        onChanged: (value) {
                                                          paymentProvider
                                                              .setVoucher(value!);    
                                                        },
                                                        activeColor:
                                                            AppColor.primaryColor,
                                                        visualDensity:
                                                            VisualDensity.compact,
                                                      )
                                                    ],
                                                  ),
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
                        onpressed: paymentProvider.selectedVoucher == null
                            ? (){}
                            : () {
                                final pay = context.read<PaymentProvider>();
                                pay.verifyPromoCode(context,widget.courseId, paymentProvider.selectedVoucher!);
                                showSnackbar(context, pay.verify.message?? '');
                                Navigator.pop(context);
                              },
                        text: "Confirm",
                        buttoncolor: paymentProvider.selectedVoucher == null
                            ? AppColor.greyButton
                            : AppColor.primaryColor,
                        textColor: AppColor.whiteColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}