import 'package:etutor/features/payment/model/promo_code_model.dart' as promo_code_model;
import 'package:etutor/features/payment/service/payment_srvice.dart';
import 'package:flutter/widgets.dart';

class PromoCodeProvider extends ChangeNotifier{
bool ispromoLoading = false;

List<promo_code_model.Data> _promocodes =[];
List<promo_code_model.Data> get promocodes =>_promocodes;
  // get promo code
  Future getPromoCode(
    BuildContext context,
  ) async {
    ispromoLoading = true;
    notifyListeners();
    try {
      final response = await PaymentServices().getPromoCode(context: context);
      if (response != null && response.data != null) {
        _promocodes = response.data!;
         notifyListeners();
      } else {
        _promocodes = [];
      }
    } catch (e) {
      debugPrint('Error fetching popular courses: $e');
      _promocodes = [];
    }
    ispromoLoading = false;
    notifyListeners();
  }
}