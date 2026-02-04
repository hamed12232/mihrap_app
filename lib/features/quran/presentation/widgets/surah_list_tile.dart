import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/constants/app_colors.dart';

class SurahListTile extends StatelessWidget {
  final int surahNumber;
  final VoidCallback onTap;

  const SurahListTile({
    super.key,
    required this.surahNumber,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.border, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  quran.getSurahName(surahNumber),
                  style: GoogleFonts.cairo(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Arabic Name
            Column(
              children: [
                Text(
                  quran.getSurahNameArabic(surahNumber),
                  style: GoogleFonts.amiri(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors
                        .cardWhite, // Using accent color for Arabic name
                  ),
                ),
                Text(
                  '${quran.getVerseCount(surahNumber).toString().split('').map((e) => '0123456789'.contains(e) ? '٠١٢٣٤٥٦٧٨٩'['0123456789'.indexOf(e)] : e).join('')} آيات  • ${quran.getPlaceOfRevelation(surahNumber) == 'Makkah' ? 'مكية' : 'مدنية'}',
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: 0.785398, // 45 degrees
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Text(
                  '$surahNumber',
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
