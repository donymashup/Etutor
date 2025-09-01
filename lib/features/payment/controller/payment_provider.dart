import 'package:etutor/features/payment/service/payment_srvice.dart';
import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
Map<String, dynamic>? _selectedPayment;
String? _selectedVoucher;
bool isProcessing = false;
String? orderId ;

Map<String, dynamic>? get selectedPayment => _selectedPayment;
String? get selectedVoucher => _selectedVoucher;

  void setPaymentMethod(Map<String, dynamic> method) {
    _selectedPayment = method;
    notifyListeners();
  }
  
  void setVoucher(String voucher) {
    _selectedVoucher = voucher;
    notifyListeners();
  }

  void clearVoucher() {
    _selectedVoucher = null;
    notifyListeners();
  }
 
 // create Razorpay order id
  Future<String?> createOrderId({
    required BuildContext context,
    required String courseId,
    required String amount,
    required String promoCode,
  }) async {
    try {
      isProcessing = true;
      notifyListeners();

      final response = await PaymentServices().createOrderId(
        amount: amount,  
        context: context, 
        courseid: courseId, 
        promoCode: promoCode,
      );

      if (response != null && response.type == "success") {
        orderId = response.orderid;
        isProcessing = false;
        notifyListeners();
        return orderId;
      } else {
        isProcessing = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      isProcessing = false;
      notifyListeners();
      return null;
    }
  }

  // // Enroll student after payment success
  // Future<void> enrollStudent({
  //   required BuildContext context,
  //   required String courseId,
  //   required String paymentId,
  //   required String orderId,
  //   required String signature,
  // }) async {
  //   try {
  //     final response = await PaymentService().enrollStudent(
  //       courseId: courseId,
  //       paymentId: paymentId,
  //       orderId: orderId,
  //       signature: signature,
  //     );

  //     if (response['type'] == "success") {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Enrolled Successfully!")),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Enrollment Failed")),
  //       );
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Error enrolling student")),
  //     );
  //   }
  // }
}