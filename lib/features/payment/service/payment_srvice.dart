import 'dart:convert';

import 'package:etutor/common/constants/config.dart';
import 'package:etutor/common/constants/utils.dart';
import 'package:etutor/features/payment/model/create_orderid_model.dart';
import 'package:etutor/features/payment/model/enroll_student_model.dart';
import 'package:etutor/features/payment/model/free_enroll_student_model.dart';
import 'package:etutor/features/payment/model/promo_code_model.dart';
import 'package:etutor/features/payment/model/verify_promo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PaymentServices {
  final storage = const FlutterSecureStorage();

  // Create orderid
  Future<OrderIdModel?> createOrderId({
    required BuildContext context,
    required String amount,
    required String courseid,
    required String promoCode,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
        url: '$baseUrl$orderId',
        token: token,
        fields: {
          'amount': amount,
          'courseid': courseid,
          'promo_code': promoCode,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final orderIdModel = OrderIdModel.fromJson(jsonResponse);
          return orderIdModel;
        }
      } else {
        debugPrint("Failed to create order id : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  // get promo codes
  Future<PromoCodeModel?> getPromoCode({
    required BuildContext context,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendGetRequestWithToken(
        url: '$baseUrl$promoCode',
        token: token,
      );
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final promoCodeModel = PromoCodeModel.fromJson(jsonResponse);
          return promoCodeModel;
        }
      } else {
        debugPrint("Failed to fetch promo code : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  // verify promo codes
  Future<VerifyPromoModel?> verifyPromo({
    required BuildContext context,
    required String courseId,
    required String promo,
  }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
          url: '$baseUrl$verifyPromoCode',
          token: token,
          fields: {
            'courseid': courseId,
            'promo_code': promo,
          });
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final verifyPromoModel = VerifyPromoModel.fromJson(jsonResponse);
          return verifyPromoModel;
        }
      } else {
        debugPrint("Failed to verify promo code : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  // Free Enroll Student
  Future<FreeEnrollStudentModel?> freeenroll(
      {required BuildContext context,
      required String courseid,
      required String promo,
      required String amount}) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
          url: '$baseUrl$freeEnrollStudent',
          token: token,
          fields: {
            'courseid': courseid,
            'promo': promo,
            'amount': amount,
          });
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final freeEnrollStudentModel =
              FreeEnrollStudentModel.fromJson(jsonResponse);
          return freeEnrollStudentModel;
        }
      } else {
        debugPrint("Failed to free enroll student : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  // Enroll Student
  Future<EnrollStudentModel?> enrollStudent(
      {required BuildContext context,
      required String courseid,
      required String paymentId ,
      required String orderId,
      required String signature,
      required String amount,
      required String promo,
      }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
          url: '$baseUrl$enroll',
          token: token,
          fields: {
            'courseid': courseid,
            'promo':promo,
            'amount':amount,
            'paymentid':paymentId,
            'orderid':orderId,
            'signature':signature,
          });
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final enrollStudentModel =
              EnrollStudentModel.fromJson(jsonResponse);
          return enrollStudentModel;
        }
      } else {
        debugPrint("Failed to enroll student : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }

  // confirm in app purchase
  Future<EnrollStudentModel?> iapConfirm(
      {required BuildContext context,
      required String courseid,
      }) async {
    try {
      final token = await storage.read(key: 'token');
      if (token == null) {
        showSnackbar(context, "Token not found. Please log in again.");
        return null;
      }
      final response = await sendPostRequestWithToken(
          url: '$baseUrl$enroll',
          token: token,
          fields: {
            'courseid': courseid,
          });
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        if (jsonResponse == null || jsonResponse.isEmpty) {
          showSnackbar(context, 'Invalid response from server');
          return null;
        } else {
          final enrollStudentModel =
              EnrollStudentModel.fromJson(jsonResponse);
          return enrollStudentModel;
        }
      } else {
        debugPrint("Failed to confirm in app purchase : ${response.statusCode}");
        return null;
      }
    } catch (e) {
      showSnackbar(context, "Error : $e");
      return null;
    }
  }
}
