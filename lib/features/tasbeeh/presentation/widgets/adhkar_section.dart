import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';
import 'dhikr_chip.dart';

class AdhkarSection extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDhikrSelected;

  const AdhkarSection({
    super.key,
    required this.selectedIndex,
    required this.onDhikrSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'اسحب للمزيد',
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                'الأذكار الشائعة',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Dhikr Chips Row
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DhikrChip(
                label: 'الله أكبر',
                isSelected: selectedIndex == 2,
                onTap: () => onDhikrSelected(2),
              ),
              const SizedBox(width: 12),
              DhikrChip(
                label: 'الحمد لله',
                isSelected: selectedIndex == 1,
                onTap: () => onDhikrSelected(1),
              ),
              const SizedBox(width: 12),
              DhikrChip(
                label: 'سبحان الله',
                isSelected: selectedIndex == 0,
                onTap: () => onDhikrSelected(0),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
