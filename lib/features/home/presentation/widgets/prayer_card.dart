import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

/// Large prayer card showing current/next prayer - Exact Stitch Design
class PrayerCard extends StatelessWidget {
  final String prayerNameArabic;
  final String remainingTime;
  final String location;

  const PrayerCard({
    super.key,
    required this.prayerNameArabic,
    required this.remainingTime,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Positioned(
          //   left: -10,
          //   bottom: 0,
          //   child: Image.asset(
          //     AppImages.backgroundImage,
          //     width: 400,
          //     height: 300,
          //     fit: BoxFit.fitWidth,
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'الصلاة القادمة',
                          style: GoogleFonts.cairo(
                            fontSize: 12,
                            color: AppColors.textOnLightSecondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  prayerNameArabic,
                  style: GoogleFonts.cairo(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textOnLight,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 16),
                // Location - Bottom Center
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Iconsax.location,
                      size: 16,
                      color: AppColors.textOnLightSecondary,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      location,
                      style: GoogleFonts.cairo(
                        fontSize: 13,
                        color: AppColors.textOnLightSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'متبقي',
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: AppColors.textOnLightSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  remainingTime,
                  style: GoogleFonts.cairo(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textOnLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
