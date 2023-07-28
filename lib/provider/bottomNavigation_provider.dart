import 'package:flutter/material.dart';

class BottomNavigationProvider with ChangeNotifier {
  int _index = 0;

  int get currentPage => _index;

  updateCurrentPage(int index) {
    _index = index;
    notifyListeners();
  }
}
