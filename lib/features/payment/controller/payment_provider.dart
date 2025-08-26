import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
Map<String, dynamic>? _selectedPayment;
String? _selectedVoucher;


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
}