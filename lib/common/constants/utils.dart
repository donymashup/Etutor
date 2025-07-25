import 'package:etutor/common/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// function for  custom snackbar
void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(child: Text(text,style: TextStyle(color: AppColor.whiteColor),)),
      backgroundColor: AppColor.whiteColorTrasparent,
      elevation: 6,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}

// function for post request
  Future<http.StreamedResponse> sendPostRequest({
    required String url,
    required Map<String, String> fields,
  }) async {
    final request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(fields);
    return await request.send();
  }

// function for get request
Future<http.StreamedResponse> sendGetRequest({
  required String url,
}) async {
  final request = http.Request('GET', Uri.parse(url));
  return await request.send();
}
