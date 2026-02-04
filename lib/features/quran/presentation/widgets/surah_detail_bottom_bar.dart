import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';

class SurahDetailBottomBar extends StatelessWidget {
  final VoidCallback onSaveProgress;
  final VoidCallback onListen;
  final VoidCallback onTafseer;

  const SurahDetailBottomBar({
    super.key,
    required this.onSaveProgress,
    required this.onListen,
    required this.onTafseer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomAction('التفسير', Iconsax.book, onTafseer),
          _buildBottomAction('استماع', Iconsax.headphone, onListen),

          // Save Progress Button
          ElevatedButton.icon(
            onPressed: onSaveProgress,
            icon: const Icon(Icons.bookmark, size: 16),
            label: Text(
              'حفظ التقدم',
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.cardWhite,
              foregroundColor: AppColors.textOnLight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.cardGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: AppColors.textOnLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
