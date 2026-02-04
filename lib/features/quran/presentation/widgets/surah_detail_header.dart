import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/constants/app_colors.dart';

class SurahDetailHeader extends StatelessWidget {
  final int surahNumber;
  final VoidCallback onBack;

  const SurahDetailHeader({
    super.key,
    required this.surahNumber,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.surface, // Or transparent if desired
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.cardGray,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Iconsax.setting_4,
              color: AppColors.textOnLight,
              size: 20,
            ),
          ),

          Column(
            children: [
              Text(
                quran.getSurahNameArabic(surahNumber),
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textOnLight,
                ),
              ),
              Text(
                'الجزء ${quran.getJuzNumber(surahNumber, 1)}', // Simplified Juz logic
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          // Back Button (Right)
          GestureDetector( 
            onTap: onBack,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.cardGray,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Icon(
                Iconsax.arrow_right_3,
                color: AppColors.textOnLight,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
