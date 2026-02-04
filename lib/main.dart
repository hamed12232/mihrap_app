import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/home/presentation/screens/home_screen.dart';

void main() {
  runApp(const MihrapApp());
}

class MihrapApp extends StatelessWidget {
  const MihrapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mihrap',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Can be changed to ThemeMode.system
      home: const HomeScreen(),
    );
  }
}
