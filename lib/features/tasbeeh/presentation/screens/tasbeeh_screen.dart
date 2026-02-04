import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../home/presentation/widgets/home_bottom_nav_bar.dart';
import '../widgets/adhkar_section.dart';
import '../widgets/count_button.dart';
import '../widgets/counter_circle.dart';
import '../widgets/tasbeeh_header.dart';
import '../widgets/vibration_toggle.dart';

/// Digital Tasbeeh Screen - Exact Stitch Design
class TasbeehScreen extends StatefulWidget {
  const TasbeehScreen({super.key});

  @override
  State<TasbeehScreen> createState() => _TasbeehScreenState();
}

class _TasbeehScreenState extends State<TasbeehScreen> {
  int _count = 33;
  int _totalSession = 165;
  bool _vibrationEnabled = false;
  int _selectedDhikrIndex = 0;

  final List<String> _adhkar = ['سبحان الله', 'الحمد لله', 'الله أكبر'];

  /// Convert number to Arabic numerals
  String _toArabicNumerals(int number) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number
        .toString()
        .split('')
        .map((d) => arabicDigits[int.parse(d)])
        .join();
  }

  void _incrementCounter() {
    setState(() {
      _count++;
      _totalSession++;
    });

    // Vibrate if enabled
    if (_vibrationEnabled) {
      HapticFeedback.lightImpact();
    }
  }

  void _resetCounter() {
    setState(() {
      _count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            TasbeehHeader(
              onReset: _resetCounter,
              onBack: () => Navigator.of(context).pop(),
            ),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 32),

                    // Counter Circle
                    CounterCircle(
                      count: _count,
                      dhikrText: _adhkar[_selectedDhikrIndex],
                      onTap: _incrementCounter,
                    ),

                    const SizedBox(height: 24),

                    // Session Total
                    Text(
                      'إجمالي الجلسة: ${_toArabicNumerals(_totalSession)}',
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Count Button
                    CountButton(onTap: _incrementCounter),

                    const SizedBox(height: 24),

                    // Vibration Toggle
                    VibrationToggle(
                      isEnabled: _vibrationEnabled,
                      onChanged: (value) {
                        setState(() {
                          _vibrationEnabled = value;
                        });
                      },
                    ),

                    const SizedBox(height: 32),

                    // Common Adhkar Section
                    AdhkarSection(
                      selectedIndex: _selectedDhikrIndex,
                      onDhikrSelected: (index) {
                        setState(() {
                          _selectedDhikrIndex = index;
                          _count = 0;
                        });
                      },
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const HomeBottomNavBar(initialIndex: 1),
    );
  }
}
