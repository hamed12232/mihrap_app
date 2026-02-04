import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class TasbeehHeader extends StatelessWidget {
  final VoidCallback onReset;
  final VoidCallback onBack;

  const TasbeehHeader({super.key, required this.onReset, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Arrow (reset)
          GestureDetector(
            onTap: onReset,
            child: const Icon(
              Iconsax.refresh,
              color: AppColors.textPrimary,
              size: 24,
            ),
          ),

          // Title
          Text(
            'السبحة الرقمية',
            style: GoogleFonts.cairo(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),

          // Right Arrow (back)
          GestureDetector(
            onTap: onBack,
            child: const Icon(
              Iconsax.arrow_right_3,
              color: AppColors.textPrimary,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
