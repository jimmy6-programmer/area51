import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const Area51App());
}

class Area51App extends StatefulWidget {
  const Area51App({super.key});

  @override
  State<Area51App> createState() => _Area51AppState();
}

class _Area51AppState extends State<Area51App> {
  final _themeProvider = ThemeProvider();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Area 51',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeProvider.themeMode,
      home: const WelcomeScreen(),
    );
  }
}
