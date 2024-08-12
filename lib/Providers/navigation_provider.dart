import 'package:flutter/material.dart';


class NavigationProvider extends ChangeNotifier {
  int _welcomeIndex = 0;
  int get welcomeIndex => _welcomeIndex;



  void setWelcomeIndex(int index) {
    _welcomeIndex = index;
    notifyListeners();
  }





  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  int _newIndex = 0;
  int get newIndex => _newIndex;
  void setNewIndex(int index) {
    _newIndex = index;
    notifyListeners();
  }
}
