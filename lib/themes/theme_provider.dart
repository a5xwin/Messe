import 'package:messe/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:messe/themes/dark_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;
  static const String _themePreferenceKey = 'themePreference';

  ThemeProvider() {
    _loadTheme();
  }

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _themeData == darkMode;

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getBool(_themePreferenceKey);
    
    if (savedTheme != null) {
      _themeData = savedTheme ? darkMode : lightMode;
      notifyListeners();
    }
  }

  Future<void> _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themePreferenceKey, isDark);
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      _themeData = darkMode;
      _saveTheme(true);
    } else {
      _themeData = lightMode;
      _saveTheme(false);
    }
    notifyListeners();
  }
}