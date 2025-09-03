import 'package:etutor/features/payment/service/payment_srvice.dart';
import 'package:flutter/material.dart';
import 'package:etutor/features/payment/model/promo_code_model.dart' as promo_code_model;

class PaymentProvider extends ChangeNotifier {
  Map<String, dynamic>? _selectedPayment;
  String? _selectedVoucher;
  bool isProcessing = false;
  String? orderId;
 
  bool ispromoLoading = false;
  List<promo_code_model.Data> _promocodes = [];
  List<promo_code_model.Data> _filteredPromocodes = [];
  String _searchQuery = '';

  Map<String, dynamic>? get selectedPayment => _selectedPayment;
  String? get selectedVoucher => _selectedVoucher;
  List<promo_code_model.Data> get promocodes => _promocodes;
  List<promo_code_model.Data> get filteredPromocodes => _filteredPromocodes;
  String get searchQuery => _searchQuery;

  void setPaymentMethod(Map<String, dynamic> method) {
    _selectedPayment = method;
    notifyListeners();
  }

  void setVoucher(String voucher) {
    // Toggle selection - if same voucher is selected, unselect it
    if (_selectedVoucher == voucher) {
      _selectedVoucher = null;
    } else {
      _selectedVoucher = voucher;
    }
    notifyListeners();
  }

  void clearVoucher() {
    _selectedVoucher = null;
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
  // Future<String?> createOrderId({
  //   required BuildContext context,
  //   required String courseId,
  //   required String amount,
  //   required String promoCode,
  // }) async {
  //   try {
  //     isProcessing = true;
  //     notifyListeners();
  //     final response = await PaymentServices().createOrderId(
  //       amount: amount,
  //       context: context,
  //       courseid: courseId,
  //       promoCode: promoCode,
  //     );
  //     if (response != null && response.type == "success") {
  //       orderId = response.orderid;
  //       isProcessing = false;
  //       notifyListeners();
  //       return orderId;
  //     } else {
  //       isProcessing = false;
  //       notifyListeners();
  //       return null;
  //     }
  //   } catch (e) {
  //     isProcessing = false;
  //     notifyListeners();
  //     return null;
  //   }
  // }

  // Get promo code
  Future getPromoCode(BuildContext context) async {
    ispromoLoading = true;
    notifyListeners();
    try {
      final response = await PaymentServices().getPromoCode(context: context);
      if (response != null && response.data != null) {
        _promocodes = response.data!;
        _filteredPromocodes = List.from(_promocodes); // Initialize filtered list
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
}