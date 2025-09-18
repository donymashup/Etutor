import 'package:etutor/features/payment/model/free_enroll_student_model.dart';
import 'package:etutor/features/payment/model/verify_promo_model.dart';
import 'package:etutor/features/payment/service/payment_srvice.dart';
import 'package:flutter/material.dart';
import 'package:etutor/features/payment/model/promo_code_model.dart' as promo_code_model;
import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentProvider extends ChangeNotifier {
  Map<String, dynamic>? _selectedPayment;
  String? _selectedVoucher;
  bool isProcessing = false;
  String? orderId;
  String? _total;
  bool ispromoLoading = false;
  bool isVerifying = false;
  List<promo_code_model.Data> _promocodes = [];
  VerifyPromoModel _verify = VerifyPromoModel();
  List<promo_code_model.Data> _filteredPromocodes = [];
  String _searchQuery = '';
  List<ProductDetails> _products = [];


  Map<String, dynamic>? get selectedPayment => _selectedPayment;
  String? get selectedVoucher => _selectedVoucher;
  List<promo_code_model.Data> get promocodes => _promocodes;
  List<promo_code_model.Data> get filteredPromocodes => _filteredPromocodes;
  String get searchQuery => _searchQuery;
  String? get total => _total;
  VerifyPromoModel get verify => _verify;
  bool isLoading = false;
  FreeEnrollStudentModel? _freeEnrollData;
  FreeEnrollStudentModel? get freeEnrollData => _freeEnrollData;
  List<ProductDetails> get products => _products;
  //set payment method
  void setPaymentMethod(Map<String, dynamic> method) {
    _selectedPayment = method;
    notifyListeners();
  }

  //set products details foe iap
  void setProducts(List<ProductDetails> product) {
    _products  = product;
    notifyListeners();
  }

// select voucher
  void setVoucher(String voucher) {
    if (_selectedVoucher == voucher) {
      _selectedVoucher = null;
    } else {
      _selectedVoucher = voucher;
    }
    notifyListeners();
  }

  void clearVoucher(String amt) {
    _selectedVoucher = null;
    _total = amt;
    notifyListeners();
  }

  // Filter promo codes based on search query
  void filterPromoCodes(String query) {
    _searchQuery = query;
    
    if (query.isEmpty) {
      _filteredPromocodes = List.from(_promocodes);
    } else {
      _filteredPromocodes = _promocodes.where((promo) {
        return promo.code!.toLowerCase().contains(query.toLowerCase()) ||
               (promo.expiry?.toLowerCase().contains(query.toLowerCase()) ?? false);
      }).toList();
    }
    
    notifyListeners();
  }

  // Clear search and reset filter
  void clearFilter() {
    _searchQuery = '';
    _filteredPromocodes = List.from(_promocodes);
    notifyListeners();
  }

  // // Create Razorpay order id
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

  // Get promo code
  Future getPromoCode(BuildContext context) async {
    ispromoLoading = true;
    notifyListeners();
    try {
      final response = await PaymentServices().getPromoCode(context: context);
      if (response != null && response.data != null) {
        _promocodes = response.data!;
        _filteredPromocodes = List.from(_promocodes); 
        notifyListeners();
      } else {
        _promocodes = [];
        _filteredPromocodes = [];
      }
    } catch (e) {
      debugPrint('Error fetching promo codes: $e');
      _promocodes = [];
      _filteredPromocodes = [];
    }
    ispromoLoading = false;
    notifyListeners();
  }

  //set total amt
  void setTotalAmt(String amt){
    _total =amt;
    notifyListeners();
  }

  //verify promo code
  Future verifyPromoCode(BuildContext context,String courseId, String promo) async {
    isVerifying = true;
    notifyListeners();
    try {
      final response = await PaymentServices().verifyPromo(context: context, courseId: courseId, promo: promo);
      if (response != null && response.type == 'success') {
        _verify = response;
        _total = response.finalAmount?.toString();
        notifyListeners();
      } else {
        _verify = VerifyPromoModel();
      }
    } catch (e) {
      debugPrint('Error fetching promo codes: $e');
       _verify = VerifyPromoModel();
    }
    isVerifying = false;
    notifyListeners();
  }

  // Free enroll method
  Future<bool> freeEnrollStudent({
    required BuildContext context,
    required String courseid,
    required String promo,
    required String amount,
  }) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await PaymentServices().freeenroll(
        context: context,
        courseid: courseid,
        promo: promo,
        amount: amount,
      );

      if (response != null && response.type == 'success') {
        _freeEnrollData = response;
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        _freeEnrollData = null;
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint('Error in freeEnrollStudent: $e');
      _freeEnrollData = null;
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void clear() {
    _freeEnrollData = null;
    notifyListeners();
  }
}
