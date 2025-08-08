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


// Function for GET request with token
Future<http.StreamedResponse> sendGetRequestWithToken({
  required String url,
  required String token,
}) async {
  final request = http.Request('GET', Uri.parse(url));
  request.headers.addAll({
    'Authorization': 'Bearer $token',
  });

  return await request.send();
}

// Function for POST request with token
Future<http.StreamedResponse> sendPostRequestWithToken({
  required String url,
  required String token,
  required Map<String, String> fields,
}) async {
  final request = http.MultipartRequest('POST', Uri.parse(url));
  request.fields.addAll(fields);
  request.headers.addAll({
    'Authorization': 'Bearer $token',
  });

  return await request.send();
}

//fuction to convert ratings to star
Widget ratingtoStar (double rating){
 int wholeStar = rating.floor();
 double halfStar = rating-wholeStar;
  return Row(
   mainAxisSize: MainAxisSize.min,
   children: [
 
    ...List.generate(5, (index) {
      if(index < wholeStar ){
        return Icon(Icons.star,color: Colors.amber,size:18);
      }else if (halfStar >= .5){
        halfStar =0.0;
        return Icon(Icons.star_half_outlined,color: Colors.amber,size: 18,);
      }else{
        return Icon(Icons.star_border_outlined,color: Colors.amber,size: 18,);
      }
    })
   ],
  );
}