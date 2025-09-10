import 'package:etutor/features/subscribed_course/model/videos_model.dart' as videos_model;
import 'package:flutter/foundation.dart';

class VideoPlayerProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  List<videos_model.Data> _playlist = [];
  bool _isLoading = false;

  int get selectedIndex => _selectedIndex;
  List<videos_model.Data> get playlist => _playlist;
  bool get isLoading => _isLoading;
  
  videos_model.Data? get currentVideo => 
      _playlist.isNotEmpty ? _playlist[_selectedIndex] : null;

  void setPlaylist(List<videos_model.Data> videos) {
    _playlist = videos;
    notifyListeners();
  }

  void selectVideo(int index) {
    if (index >= 0 && index < _playlist.length) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  // void setLoading(bool loading) {
  //   _isLoading = loading;
  //   notifyListeners();
  // }

  void nextVideo() {
    if (_selectedIndex < _playlist.length - 1) {
      _selectedIndex++;
      notifyListeners();
    }
  }

  void previousVideo() {
    if (_selectedIndex > 0) {
      _selectedIndex--;
      notifyListeners();
    }
  }
}