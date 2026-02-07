import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/services/qibla_service.dart';
import '../widgets/compass_widget.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  double _qiblaDirection = 0.0;
  double _currentHeading = 0.0;
  String _locationName = 'جاري تحديد الموقع...';
  bool _isLoading = true;
  StreamSubscription<CompassEvent>? _compassSubscription;

  @override
  void initState() {
    super.initState();
    _initQibla();
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    super.dispose();
  }

  Future<void> _initQibla() async {
    try {
      // 1. Request Locations Permission
      final status = await Permission.locationWhenInUse.request();

      if (status.isGranted) {
        // 2. Get Current Location
        final position = await Geolocator.getCurrentPosition();

        // 3. Calculate Qibla Direction
        final qiblaDir = QiblaService.calculateQiblaDirection(
          position.latitude,
          position.longitude,
        );

        setState(() {
          _qiblaDirection = qiblaDir;
          // In a real app, use Geocoding to get city name
          // For now, we can show coordinates or keep it simple
          _locationName =
              'الموقع الحالي (${position.latitude.toStringAsFixed(2)}, ${position.longitude.toStringAsFixed(2)})';
          _isLoading = false;
        });

        // 4. Start Compass Listener
        _compassSubscription = FlutterCompass.events?.listen((event) {
          setState(() {
            // Use headingForCameraMode if available for smoother rotation
            _currentHeading = event.heading ?? 0;
          });
        });
      } else {
        setState(() {
          _locationName = 'يرجى تفعيل الموقع';
          _isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Error initializing Qibla: $e');
      setState(() {
        _locationName = 'خطأ في تحديد الموقع';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.more_vert,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                    onPressed: () {
                      // TODO: Show options menu
                    },
                  ),
                  Text(
                    'اتجاه القبلة',
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textPrimary,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Title and Subtitle
            Text(
              'تحديد الاتجاه',
              style: GoogleFonts.cairo(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'ضع بوصلة الهاتف نحو علامة القبلة المضيئة',
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 40),

            // Compass
            Expanded(
              child: Center(
                child: _isLoading
                    ? const CircularProgressIndicator(color: AppColors.accent)
                    : CompassWidget(
                        qiblaDirection: _qiblaDirection,
                        currentHeading: _currentHeading,
                      ),
              ),
            ),

            // Location and Degree Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الموقع الحالي',
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _locationName,
                        style: GoogleFonts.cairo(
                          fontSize: 14, // Slightly smaller to fit coordinates
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'الدرجة',
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_qiblaDirection.toStringAsFixed(1)}°',
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Info Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Iconsax.info_circle,
                      color: AppColors.textSecondary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'عرض المسائل على الخريطة',
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        color: AppColors.textPrimary,
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
