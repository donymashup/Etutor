import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
Map<String, String>? _selectedPayment;
String? _selectedVoucher;


Map<String, String>? get selectedPayment => _selectedPayment;
String? get selectedVoucher => _selectedVoucher;

  void setPaymentMethod(Map<String, String> method) {
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