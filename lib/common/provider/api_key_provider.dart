import 'package:etutor/common/services/api_key_service.dart';
import 'package:flutter/material.dart';

class ApiKeyProvider extends ChangeNotifier{

String apiKey = '';

Future  fetchApiKey() async{
  final response = await ApiKeyService().razorApiKey();
  if(response != null){
      apiKey = response.key!;
      notifyListeners();
  }else{
      apiKey ='';
      notifyListeners();
  }
}
}