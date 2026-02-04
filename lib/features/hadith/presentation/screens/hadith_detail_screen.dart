import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class HadithDetailScreen extends StatelessWidget {
  final Map<String, dynamic> hadith;

  const HadithDetailScreen({super.key, required this.hadith});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48), // Placeholder for balance
                  Text(
                    'تفاصيل الحديث',
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textOnLight,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Iconsax.arrow_right_3,
                      color: AppColors.textOnLight,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    // Book Name Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardGray.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.cardGray.withOpacity(0.5),
                        ),
                      ),
                      child: Text(
                        hadith['collectionName'] ?? '',
                        style: GoogleFonts.cairo(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Arabic Content
                    Text(
                      hadith['content'] ?? '',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.amiri(
                        fontSize: 22,
                        height: 2.0,
                        color: AppColors.textOnLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 48),
                    // Divider
                    Container(
                      height: 1,
                      width: 100,
                      color: AppColors.cardGray.withOpacity(0.3),
                    ),
                    const SizedBox(height: 32),
                    // Translation (Optional - for future use or Indonesian if kept)
                    // Currently naming it description or info
                    Text(
                      'رقم الحديث: ${hadith['number']}',
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
