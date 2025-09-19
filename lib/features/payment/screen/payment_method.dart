import 'package:etutor/common/constants/app_constants.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/common/provider/api_key_provider.dart';
import 'package:etutor/common/widgets/back_button.dart';
import 'package:etutor/common/widgets/custom_button.dart';
import 'package:etutor/features/home/provider/user_details_provider.dart';
import 'package:etutor/features/payment/controller/payment_provider.dart';
import 'package:etutor/features/payment/screen/payment_failed.dart';
import 'package:etutor/features/payment/screen/payment_succesfull.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentMethod extends StatefulWidget {
  final String price;
  final String courseId;
  final String promo;
  final String courseName;
  const PaymentMethod(
      {super.key,
      required this.price,
      required this.courseId,
      required this.promo,
      required this.courseName});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  Map<String, dynamic>? _selectedOption;
  late Razorpay _razorpay;
  late String _orderid, _paymentid, _signature;
  ApiKeyProvider apiKeyProvider = ApiKeyProvider();
  PaymentProvider paymentProvider = PaymentProvider();

  @override
  void initState() {
    super.initState();
    _load();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Future<void> _load() async {
    await context.read<ApiKeyProvider>().fetchApiKey();
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  final List<Map<String, dynamic>> method = const [
    {
      "name": "Razor Pay",
      "icon": Icons.credit_card_rounded,
      "info": "Card, UPI, Net Banking & Wallets"
    },
    {
      "name": "In-App Purchase",
      "icon": Icons.smartphone_rounded,
      "info": "Google Play / App Store",
    },
  ];

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    _paymentid = response.paymentId!;
    _signature = response.signature!;
    _orderid = response.orderId!;

    debugPrint(response.paymentId!);
    debugPrint(response.signature!);
    debugPrint(response.orderId!);

    // enroll API
    bool enroll = await context.read<PaymentProvider>().enrollStudent(
          context: context,
          courseid: widget.courseId,
          paymentId: _paymentid,
          orderId: _orderid,
          signature: _signature,
          promo: widget.promo,
          amount: widget.price,
        );
    enroll
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => PaymentSuccesfull()),
          )
        : showSnackbar(context, "Couldn't enrll student, Somthing went wrong");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PaymentFailed()),
    );
    showSnackbar(context, "Payment failed: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showSnackbar(context, "External wallet: ${response.walletName}");
  }

  @override
  Widget build(BuildContext context) {
    apiKeyProvider = context.watch<ApiKeyProvider>();
    paymentProvider = context.watch<PaymentProvider>();
    final provider = context.read<PaymentProvider>();
    if (paymentProvider.isProcessing) {
      return Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Center(
          child: Lottie.asset('assets/lottie/lottieloading1.json', height: 120),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.whiteColor,
        title: Text(
          "Complete Your Purchase",
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15),
                        child: Text("Choose payment method"),
                      ),
                      // ),
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
                                    border: _selectedOption?['name'] ==
                                            methods['name']
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
                                              // child: Image.asset(
                                              //   methods['icon']!,
                                              // ),
                                              child: Icon(
                                                methods['icon']!,
                                                color: AppColor.primaryColor,
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
                                        value: methods,
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
                        onpressed: _selectedOption == null
                            ? () {}
                            : () async {
                                if (_selectedOption?['name'] == "Razor Pay") {
                                  debugPrint(apiKeyProvider.apiKey);
                                  //  create orderId
                                  final orderId = await provider.createOrderId(
                                    context: context,
                                    courseId: widget.courseId,
                                    amount: (int.parse(widget.price) * 100)
                                        .toString(),
                                    promoCode: widget.promo,
                                  );
                                  final userContact = context
                                      .read<UserDetailsProvider>()
                                      .userDetails
                                      .data!;
                                  if (orderId != null) {
                                    //Open Razorpay checkout
                                    var options = {
                                      'key': apiKeyProvider.apiKey,
                                      'amount': int.parse(widget.price) * 100,
                                      'name': 'Dream Theam',
                                      'description': widget.courseName,
                                      'order_id': orderId,
                                      'prefill': {
                                        'contact': userContact.phone,
                                        'email': userContact.email,
                                      }
                                    };

                                    try {
                                      _razorpay.open(options);
                                    } catch (e) {
                                      debugPrint("Error: $e");
                                    }
                                  } else {
                                    showSnackbar(
                                        context, "Failed to create order");
                                  }
                                } else if (_selectedOption?['name'] ==
                                    "In-App Purchase") {
                                  // in-app purchase
                                  await Purchases.purchaseProduct(
                                          "etutor_10k_an_sub")
                                      .then((value) async {
                                    debugPrint("customer info $value");
                                    // call inapp purchase confirm api
                                    bool confirm = await provider.iapConfirm(
                                        context: context,
                                        courseid: widget.courseId);
                                    confirm
                                        ? Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentSuccesfull()),
                                          )
                                        : Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PaymentFailed()),
                                          );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                            "Access the course from my course page"),
                                        backgroundColor: (const Color.fromARGB(
                                            255, 225, 224, 227)),
                                        action: SnackBarAction(
                                          label: 'dismiss',
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                  }).catchError((e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text(
                                            "error subscribing course"),
                                        backgroundColor: (const Color.fromARGB(
                                            255, 207, 206, 208)),
                                        action: SnackBarAction(
                                          label: 'dismiss',
                                          onPressed: () {},
                                        ),
                                      ),
                                    );
                                  });
                                }
                              },
                        text: "Pay ₹ ${widget.price}",
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
