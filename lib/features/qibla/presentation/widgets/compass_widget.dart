import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_colors.dart';

class CompassWidget extends StatelessWidget {
  final double qiblaDirection;
  final double currentHeading;

  const CompassWidget({
    super.key,
    required this.qiblaDirection,
    required this.currentHeading,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate the angle difference
    double angleDifference = qiblaDirection - currentHeading;

    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer circle with degree markers
          Transform.rotate(
            angle: -currentHeading * (math.pi / 180),
            child: CustomPaint(
              size: const Size(300, 300),
              painter: CompassPainter(),
            ),
          ),

          // Direction labels (N, S, E, W)
          Transform.rotate(
            angle: -currentHeading * (math.pi / 180),
            child: SizedBox(
              width: 300,
              height: 300,
              child: Stack(
                children: [
                  // North (ش - شمال)
                  Positioned(
                    top: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'ش',
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  // South (ج - جنوب)
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'ج',
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  // East (ق - شرق)
                  Positioned(
                    right: 10,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Text(
                        'ق',
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  // West (غ - غرب)
                  Positioned(
                    left: 10,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Text(
                        'غ',
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Center circle with degree display
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.cardDark,
              border: Border.all(color: AppColors.surfaceLight, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${currentHeading.toStringAsFixed(0)}°',
                  style: GoogleFonts.cairo(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'درجة الدوران',
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Qibla indicator (Kaaba icon)
          Transform.rotate(
            angle: angleDifference * (math.pi / 180),
            child: Transform.translate(
              offset: const Offset(0, -100),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.cardWhite,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cardWhite.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.mosque,
                  color: AppColors.textOnLight,
                  size: 28,
                ),
              ),
            ),
          ),

          // Pointer line to Qibla
          Transform.rotate(
            angle: angleDifference * (math.pi / 180),
            child: Container(
              width: 2,
              height: 100,
              margin: const EdgeInsets.only(bottom: 100),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.cardWhite,
                    AppColors.cardWhite.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CompassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw outer circle
    final outerCirclePaint = Paint()
      ..color = AppColors.surfaceLight.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, radius - 10, outerCirclePaint);

    // Draw degree markers
    for (int i = 0; i < 360; i += 10) {
      final angle = i * (math.pi / 180);
      final isMainDirection = i % 90 == 0;
      final isMajorTick = i % 30 == 0;

      final tickLength = isMainDirection ? 15.0 : (isMajorTick ? 10.0 : 5.0);
      final tickWidth = isMainDirection ? 2.0 : 1.0;

      final startRadius = radius - 10;
      final endRadius = startRadius - tickLength;

      final start = Offset(
        center.dx + startRadius * math.cos(angle - math.pi / 2),
        center.dy + startRadius * math.sin(angle - math.pi / 2),
      );

      final end = Offset(
        center.dx + endRadius * math.cos(angle - math.pi / 2),
        center.dy + endRadius * math.sin(angle - math.pi / 2),
      );

      final tickPaint = Paint()
        ..color = isMainDirection
            ? AppColors.textPrimary
            : AppColors.textSecondary.withOpacity(0.5)
        ..strokeWidth = tickWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(start, end, tickPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
