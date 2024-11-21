import 'package:flutter/material.dart';
import 'package:hw5_noteapp/theme/theme.dart';

// with => mixin
class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;
  ThemeData get themedata => _themeData; //getter
  bool get isDarkMode => _themeData == darkmode;
  set themeData(ThemeData themeData){
    _themeData = themeData;
    notifyListeners();
  }
  
  void toggleTheme(){
    _themeData = (_themeData == lightMode) ? darkmode : lightMode;
    notifyListeners();
  }
}