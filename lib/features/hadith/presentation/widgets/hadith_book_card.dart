import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class HadithBookCard extends StatelessWidget {
  final String bookName;
  final String imamName;
  final String hadithCount;
  final IconData iconInfo;
  final VoidCallback onTap;

  const HadithBookCard({
    super.key,
    required this.bookName,
    required this.imamName,
    required this.hadithCount,
    required this.iconInfo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF151515), // Darker card background
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.cardGray.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
              Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C2C2E),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$hadithCount حديث',
                    style: GoogleFonts.cairo(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Icon(
                  Iconsax.arrow_left_2,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
              ],
            ),
            
            const SizedBox(width: 16),

            // Middle: Book Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    bookName,
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.cardWhite,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    imamName,
                    style: GoogleFonts.cairo(
                      fontSize: 11, // Smaller font for Imam name
                      color: AppColors.textSecondary,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Left: Hadith Count & Arrow
            Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(iconInfo, color: AppColors.cardWhite, size: 24),
            ),
          
          ],
        ),
      ),
    );
    
  }
  }
