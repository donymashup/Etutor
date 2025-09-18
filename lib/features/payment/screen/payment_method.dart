import 'dart:async';
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
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentMethod extends StatefulWidget {
  final String price;
  final String courseId;
  final String promo;
  final String courseName;

  const PaymentMethod({
    super.key,
    required this.price,
    required this.courseId,
    required this.promo,
    required this.courseName,
  });

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  late Razorpay _razorpay;
  late String _orderid, _paymentid, _signature;
  ApiKeyProvider apiKeyProvider = ApiKeyProvider();
  PaymentProvider paymentProvider = PaymentProvider();

  //In-App Purchase variables
  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _subscription;
  bool _available = false;
  final String _productId = " "; // change with actual Play Console ID

  @override
  void initState() {
    super.initState();
    _load();

    // Razorpay
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    // In-App Purchase
    _initIAP();
  }

  Future<void> _load() async {
    await context.read<ApiKeyProvider>().fetchApiKey();
  }

  Future<void> _initIAP() async {
    _available = await _iap.isAvailable();
    if (_available) {
      _subscription = _iap.purchaseStream.listen((purchases) {
        _handlePurchaseUpdates(purchases);
      });

      final ids = <String>{_productId}; 
      final response = await _iap.queryProductDetails(ids);
      if (response.notFoundIDs.isNotEmpty) {
        debugPrint("Product not found in store: ${response.notFoundIDs}");
      }
        context.read<PaymentProvider>().setProducts(response.productDetails);
    }
  }

  @override
  void dispose() {
    _razorpay.clear();
    _subscription?.cancel();
    super.dispose();
  }

  // Razorpay Success
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    _paymentid = response.paymentId!;
    _signature = response.signature!;
    _orderid = response.orderId!;

    debugPrint("PaymentId: $_paymentid");
    debugPrint("Signature: $_signature");
    debugPrint("OrderId: $_orderid");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PaymentSuccesfull()),
    );
  }

  // Razorpay Error
  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PaymentFailed()),
    );
    showSnackbar(context, "Payment failed: ${response.message}");
  }

  // Razorpay Wallet
  void _handleExternalWallet(ExternalWalletResponse response) {
    showSnackbar(context, "External wallet: ${response.walletName}");
  }

  // IAP Purchase Handling
  void _handlePurchaseUpdates(List<PurchaseDetails> purchases) async {
    for (var purchase in purchases) {
      if (purchase.status == PurchaseStatus.purchased) {
        ///
        // Verify purchase api
        ///
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PaymentSuccesfull()),
        );
      } else if (purchase.status == PurchaseStatus.error) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PaymentFailed()),
        );
      }

      if (purchase.pendingCompletePurchase) {
        await _iap.completePurchase(purchase);
      }
    }
  }

  // Buy In-App Product
  void _buyProduct() {
    final productDetails =context.watch<PaymentProvider>().products;
    if (productDetails.isNotEmpty) {
      final product = productDetails.first;
      final purchaseParam = PurchaseParam(productDetails: product);
      _iap.buyConsumable(purchaseParam: purchaseParam);
    } else {
      showSnackbar(context, "No products available in store");
    }
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

  @override
  Widget build(BuildContext context) {
    apiKeyProvider = context.watch<ApiKeyProvider>();
    paymentProvider = context.watch<PaymentProvider>();

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
        title: const Text(
          "Complete Your Purchase",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
        ),
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
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
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                        child: Text("Choose payment method"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: method.length,
                          itemBuilder: (context, index) {
                            final methods = method[index];
                            return Container(
                              margin: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: paymentProvider.selectedPayment?['name'] ==
                                        methods['name']
                                    ? Border.all(color: AppColor.primaryColor)
                                    : Border.all(color: AppColor.greyStroke),
                              ),
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
                                                color: AppColor.greyStroke),
                                          ),
                                          child: Icon(
                                            methods['icon']!,
                                            color: AppColor.primaryColor,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(methods['name']!,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            const SizedBox(height: 5),
                                            Text(
                                              methods['info']!,
                                              style: TextStyle(
                                                color: AppColor.greyText,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Radio(
                                      value: methods,
                                      groupValue: paymentProvider.selectedPayment,
                                      onChanged: (value) {
                                          context.read<PaymentProvider>().setPaymentMethod(value!);
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
                    onpressed: paymentProvider.selectedPayment == null
                        ? () {}
                        : () async {
                            if (paymentProvider.selectedPayment?['name'] == "Razor Pay") {
                              final provider =
                                  context.read<PaymentProvider>();
                              debugPrint(apiKeyProvider.apiKey);

                              final orderId = await provider.createOrderId(
                                context: context,
                                courseId: widget.courseId,
                                amount:
                                    (int.parse(widget.price) * 100).toString(),
                                promoCode: widget.promo,
                              );

                              final userContact = context
                                  .read<UserDetailsProvider>()
                                  .userDetails
                                  .data!;

                              if (orderId != null) {
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
                            } else if (paymentProvider.selectedPayment?['name'] ==
                                "In-App Purchase") {
                                  // in app purchase
                              _buyProduct();
                            }
                          },
                    text: "Pay ₹ ${widget.price}",
                    buttoncolor: paymentProvider.selectedPayment == null
                        ? AppColor.greyButton
                        : AppColor.primaryColor,
                    textColor: AppColor.whiteColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
