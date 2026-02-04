import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

/// Prayer time row item - Exact Stitch Design
class PrayerTimeRow extends StatelessWidget {
  final IconData icon;
  final String nameArabic;
  final String time;
  final bool isActive;

  const PrayerTimeRow({
    super.key,
    required this.icon,
    required this.nameArabic,
    required this.time,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cardGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Active Indicator (dot on left)
          if (isActive)
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(right: 12),
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
            ),

          // Time - Left aligned
          Text(
            time,
            style: GoogleFonts.cairo(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),

          const Spacer(),

          // Prayer Name - Right aligned
          Text(
            nameArabic,
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(width: 12),

          // Icon - Right side
          Icon(icon, color: AppColors.textSecondary, size: 22),
        ],
      ),
    );
  }
}
