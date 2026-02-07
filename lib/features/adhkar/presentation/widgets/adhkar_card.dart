import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/models/adhkar_model.dart';

class AdhkarCard extends StatefulWidget {
  final AdhkarModel adhkar;

  const AdhkarCard({super.key, required this.adhkar});

  @override
  State<AdhkarCard> createState() => _AdhkarCardState();
}

class _AdhkarCardState extends State<AdhkarCard> {
  int _currentCount = 0;
  int _totalCount = 1;

  @override
  void initState() {
    super.initState();
    _totalCount = int.tryParse(widget.adhkar.count) ?? 1;
    _currentCount = 0;
  }

  void _incrementCount() {
    if (_currentCount < _totalCount) {
      setState(() {
        _currentCount++;
      });
    }
  }

  void _resetCount() {
    setState(() {
      _currentCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Header with category
          if (widget.adhkar.category.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_totalCount > 1)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${widget.adhkar.count} مرات',
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                Expanded(
                  child: Text(
                    widget.adhkar.category,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),

          const SizedBox(height: 16),

          // Main content - Arabic text
          Text(
            widget.adhkar.content,
            textAlign: TextAlign.right,
            style: GoogleFonts.amiri(
              fontSize: 18,
              height: 2.0,
              color: AppColors.textPrimary,
            ),
          ),

          // Description (if exists)
          if (widget.adhkar.description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.adhkar.description,
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
            ),
          ],

          const SizedBox(height: 16),

          // Footer with actions and reference
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Action buttons
              Row(
                children: [
                  _buildActionButton(Iconsax.share, () {
                    // TODO: Implement share
                  }),
                  const SizedBox(width: 12),
                  _buildActionButton(Iconsax.copy, () {
                    // TODO: Implement copy
                  }),
                  const SizedBox(width: 12),
                  _buildActionButton(Iconsax.bookmark, () {
                    // TODO: Implement bookmark
                  }),
                ],
              ),

              // Reference
              if (widget.adhkar.reference.isNotEmpty)
                Flexible(
                  child: Text(
                    widget.adhkar.reference,
                    textAlign: TextAlign.right,
                    style: GoogleFonts.cairo(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
            ],
          ),

          // Counter
          const SizedBox(height: 16),
          Center(
            child: GestureDetector(
              onTap: _incrementCount,
              onLongPress: _resetCount,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _currentCount >= _totalCount
                        ? AppColors.accent
                        : AppColors.cardWhite,
                    width: 2,
                  ),
                  color: _currentCount >= _totalCount
                      ? AppColors.accent.withOpacity(0.1)
                      : Colors.transparent,
                ),
                child: Center(
                  child:  Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$_currentCount',
                              style: GoogleFonts.cairo(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: _currentCount >= _totalCount
                                    ? AppColors.accent
                                    : AppColors.textPrimary,
                              ),
                            ),
                            Text(
                              '/ $_totalCount',
                              style: GoogleFonts.cairo(
                                fontSize: 10,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        )
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              _currentCount >= _totalCount ? 'تم الانتهاء ✓' : 'اضغط للعد',
              style: GoogleFonts.cairo(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: AppColors.textSecondary),
      ),
    );
  }
}
