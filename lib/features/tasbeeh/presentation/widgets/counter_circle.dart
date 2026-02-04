import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

/// Circular counter widget for Tasbeeh - Exact Stitch Design
class CounterCircle extends StatelessWidget {
  final int count;
  final String dhikrText;
  final VoidCallback? onTap;

  const CounterCircle({
    super.key,
    required this.count,
    required this.dhikrText,
    this.onTap,
  });

  /// Convert number to Arabic numerals
  String _toArabicNumerals(int number) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number
        .toString()
        .split('')
        .map((d) => arabicDigits[int.parse(d)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 220,
        height: 220,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.background,
          border: Border.all(color: AppColors.border, width: 3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Counter Number
            Text(
              _toArabicNumerals(count),
              style: GoogleFonts.cairo(
                fontSize: 72,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 8),
            // Dhikr Text
            Text(
              dhikrText,
              style: GoogleFonts.cairo(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
