import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turnarix/utill/app_constants.dart';

class ThemeProvider with ChangeNotifier {
  final SharedPreferences? sharedPreferences;
  ThemeProvider({@required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  bool _darkTheme = true;
  bool get darkTheme => _darkTheme;

  String? _primaryColor;
  String? get primaryColor => _primaryColor;

  String? _fontSize;
  String? get fontSize => _fontSize;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    sharedPreferences!.setBool(AppConstants.THEME, _darkTheme);
    notifyListeners();
  }

  void _loadCurrentTheme() async {
    _darkTheme = sharedPreferences!.getBool(AppConstants.THEME) ?? false;
    _primaryColor = sharedPreferences!.getString(AppConstants.PRIMARY_COLOR);
    _fontSize = sharedPreferences!.getString(AppConstants.FONT_SIZE);
    notifyListeners();
  }

  void setPrimaryColor(String color) async {
    _primaryColor = color;
    sharedPreferences!.setString(AppConstants.PRIMARY_COLOR, _primaryColor!);
    notifyListeners();
  }

  void setFontSize(String size) async {
    _fontSize = size;
    sharedPreferences!.setString(AppConstants.FONT_SIZE, _fontSize!);
    notifyListeners();
  }
}
