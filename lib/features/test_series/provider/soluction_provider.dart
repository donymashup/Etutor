import 'package:flutter/material.dart';
import '../service/tests_service.dart';

class SolutionProvider extends ChangeNotifier {
  final TestService _service = TestService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _htmlData;
  String? get htmlData => _htmlData;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> loadSolution({
    required String testId,
    required String type,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _htmlData = null;
    notifyListeners();

    try {
      final result = await _service.fetchSolution(
        context: null, 
        testId: testId,
        type: type,
      );

      if (result != null) {
        _htmlData = result;
      } else {
        _errorMessage = "No solution found.";
      }
    } catch (e) {
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
