import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';
import '../widgets/home_bottom_nav_bar.dart';
import '../widgets/home_header.dart';
import '../widgets/prayer_card.dart';
import '../widgets/prayer_time_row.dart';
import '../widgets/quick_action_button.dart';

/// Home Screen - Exact Stitch Design
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Iconsax.notification),
                const HomeHeader(
                  date: 'الجمعة، ١٥ رجب',
                  greeting: 'السلام عليكم، أحمد',
                ),
              ],
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Prayer Card
                    const PrayerCard(
                      prayerNameArabic: 'العصر',
                      remainingTime: '-١:٤٥:٠٠',
                      location: 'مكة المكرمة، السعودية',
                    ),

                    const SizedBox(height: 16),

                    // Prayer Times Section Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'اليوم',
                            style: GoogleFonts.cairo(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            'مواقيت الصلاة',
                            style: GoogleFonts.cairo(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),
                    // Prayer Times List
                    const PrayerTimeRow(
                      icon: Iconsax.moon,
                      nameArabic: 'الفجر',
                      time: '٥:١٢ ص',
                    ),
                    const PrayerTimeRow(
                      icon: Iconsax.sun_1,
                      nameArabic: 'الشروق',
                      time: '٦:٣٤ ص',
                    ),
                    const PrayerTimeRow(
                      icon: Iconsax.sun,
                      nameArabic: 'الظهر',
                      time: '١٢:٢٠ م',
                    ),
                    const PrayerTimeRow(
                      icon: Iconsax.cloud,
                      nameArabic: 'العصر',
                      time: '٣:٤٥ م',
                      isActive: true,
                    ),
                    const PrayerTimeRow(
                      icon: Iconsax.sun_fog,
                      nameArabic: 'المغرب',
                      time: '٦:٠٥ م',
                    ),
                    const PrayerTimeRow(
                      icon: Iconsax.sun_fog,
                      nameArabic: 'العشاء',
                      time: '٧:٠٥ م',
                    ),

                    const SizedBox(height: 24),

                    // Quick Action Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          QuickActionButton(
                            icon: Iconsax.discover,
                            label: 'القبلة',
                            onTap: () {},
                          ),
                          const SizedBox(width: 12),
                          QuickActionButton(
                            icon: Iconsax.building,
                            label: 'حصن المسلم',
                            onTap: () {},
                          ),
                          const SizedBox(width: 12),
                          QuickActionButton(
                            icon: Iconsax.bookmark,
                            label: 'الأذكار',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavBar(),
    );
  }
}
