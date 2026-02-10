import 'package:flutter/material.dart';

class AppTheme {
  static final _green = const Color(0xFF00FF41);
  static final _darkGreenBlack = const Color(0xFF0A1A0F);
  static final _surfaceDark = const Color(0xFF112211);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _green,
      primary: _green,
      secondary: const Color(0xFF39FF14),
      background: _darkGreenBlack,
      surface: _surfaceDark,
      surfaceTint: Colors.transparent,
      onPrimary: Colors.black,
      onSurface: Colors.white.withOpacity(0.92),
    ),
    scaffoldBackgroundColor: _darkGreenBlack,
    appBarTheme: AppBarTheme(
      backgroundColor: _darkGreenBlack,
      elevation: 0,
      centerTitle: true,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: _darkGreenBlack,
      selectedItemColor: _green,
      unselectedItemColor: Colors.white54,
      showUnselectedLabels: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _green,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        elevation: 8,
        shadowColor: _green.withOpacity(0.5),
      ),
    ),
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF006622), // darker green for light mode
      brightness: Brightness.light,
      primary: const Color(0xFF006622),
      secondary: const Color(0xFF39FF14),
    ),
    scaffoldBackgroundColor: Colors.grey[50],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 1,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF006622),
      unselectedItemColor: Colors.grey,
    ),
  );
}

// Provider-like simple state (you can later use riverpod / provider package)
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.dark;

  ThemeMode get themeMode => _themeMode;

  bool get isDark => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;
    notifyListeners();
  }
}
