import 'package:etutor/features/live/model/live_class_model.dart';
import 'package:etutor/features/live/service/live_class_service.dart';
import 'package:flutter/material.dart';

class LiveClassProvider extends ChangeNotifier {
  bool isLoading = false;

  List<Ongoing> _ongoingLiveClasses = [];
  List<Ongoing> get ongoingLiveClasses => _ongoingLiveClasses;

  List<Upcoming> _upcomingLiveClasses = [];
  List<Upcoming> get upcomingLiveClasses => _upcomingLiveClasses;

  List<Completed> _completedLiveClasses = [];
  List<Completed> get completedLiveClasses => _completedLiveClasses;

  Completed _completedLiveYear = Completed();
  Completed get completedLiveYear => _completedLiveYear;

  Months _completedLiveMonth = Months();
  Months get completedLiveMonth => _completedLiveMonth;

  Future<void> fetchLiveClasses(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await LiveClassService().getLiveClasses(context);
      if (response != null && response.liveClasses != null) {
        _ongoingLiveClasses = response.liveClasses?.ongoing ?? [];
        _upcomingLiveClasses = response.liveClasses?.upcoming ?? [];
        _completedLiveClasses = response.liveClasses?.completed ?? [];
      } else {
        _ongoingLiveClasses = [];
        _upcomingLiveClasses = [];
        _completedLiveClasses = [];
      }
    } catch (e) {
      debugPrint('Error loading attended tests: $e');
      _ongoingLiveClasses = [];
      _upcomingLiveClasses = [];
      _completedLiveClasses = [];
    }
    notifyListeners();

    isLoading = false;
    notifyListeners();
  }

  void setYear(String yearName) {
    _completedLiveYear = _completedLiveClasses
        .firstWhere((completedLiveYear) => completedLiveYear.name == yearName);
  }

  void setMonth(String monthName) {
    _completedLiveMonth = (_completedLiveYear.months ?? []).firstWhere(
      (completedLiveMonth) => completedLiveMonth.name == monthName,
      orElse: () => Months(data: []),
    );
  }
}
