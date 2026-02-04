import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mihrap_app/core/constants/app_images.dart';

import '../../../../core/constants/app_colors.dart';

class LastReadCard extends StatelessWidget {
  final VoidCallback onTap;

  const LastReadCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 140,
      decoration: BoxDecoration(
        color: Color(0xff121212),

        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            left: -30,
            bottom: -50,
            child: Image.asset(AppImages.backgroundImage, width: 300, height: 300),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cardWhite,
                    foregroundColor: AppColors.textOnLight,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                  ),
                  child: Text(
                    'متابعة',
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Right Content (Text)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'آخر قراءة',
                            style: GoogleFonts.cairo(
                              fontSize: 12,
                              color: AppColors.cardWhite.withValues(alpha: 0.6),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(
                            Iconsax.book_1,
                            size: 16,
                            color: AppColors.textSecondary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'سورة الكهف',
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'الآية رقم ١١٠ • الجزء ١٥',
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          color: AppColors.cardWhite.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
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
