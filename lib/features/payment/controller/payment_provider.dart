import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
Map<String, String>? _selectedPayment;

  Map<String, String>? get selectedPayment => _selectedPayment;

  void setPaymentMethod(Map<String, String> method) {
    _selectedPayment = method;
    notifyListeners();
  }
}