import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class NetworkProvider extends ChangeNotifier {
  bool _isLoading =false;
  bool _hasConnection = true;
  bool get hasConnection => _hasConnection;
  bool get isLoaing => _isLoading;

  late final StreamSubscription<InternetStatus> _listener;

  NetworkProvider() {
    _listener = InternetConnection().onStatusChange.listen((status) {
      final newStatus = status == InternetStatus.connected;
      if (_hasConnection != newStatus) {
        _hasConnection = newStatus;
        notifyListeners();
      }
    });

    _manualCheck();
  }

  Future<void> _manualCheck() async {
    _hasConnection = await InternetConnection().hasInternetAccess;
    notifyListeners();
  }

  Future<void> retryConnection() async {
    _isLoading = true;
    notifyListeners();
    await _manualCheck();
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _listener.cancel();
    super.dispose();
  }
}
