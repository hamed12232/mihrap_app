import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../home/presentation/widgets/home_bottom_nav_bar.dart';
import '../widgets/settings_section.dart';
import '../widgets/settings_toggle_item.dart';
import '../widgets/settings_navigation_item.dart';

/// Settings Screen - الإعدادات
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = false;
  bool _nightModeEnabled = true;
  bool _autoRemindersEnabled = false;

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
                      Icons.arrow_forward_ios,
                      color: AppColors.textPrimary,
                      size: 20,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'الإعدادات',
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(width: 40), // Balance the header
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 8),

                    // User Profile Section
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.cardDark,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColors.surfaceLight,
                            child: Icon(
                              Iconsax.user,
                              color: AppColors.textSecondary,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'مستخدم زائر',
                                  style: GoogleFonts.cairo(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  'يمكنك تسجيل الدخول لحفظ بياناتك',
                                  style: GoogleFonts.cairo(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // General Settings Section
                    SettingsSection(
                      title: 'عام',
                      children: [
                        SettingsToggleItem(
                          icon: Iconsax.notification,
                          title: 'التنبيهات',
                          subtitle: 'تفعيل الإشعارات',
                          value: _notificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                        ),
                        SettingsToggleItem(
                          icon: Iconsax.location,
                          title: 'الموقع',
                          subtitle: 'تحديد موقعك الحالي',
                          value: _locationEnabled,
                          onChanged: (value) {
                            setState(() {
                              _locationEnabled = value;
                            });
                          },
                        ),
                        SettingsNavigationItem(
                          icon: Iconsax.global,
                          title: 'اللغة',
                          subtitle: 'العربية الأساسية',
                          onTap: () {
                            // TODO: Navigate to language selection
                          },
                        ),
                        SettingsToggleItem(
                          icon: Iconsax.moon,
                          title: 'الوضع الليلي',
                          subtitle: 'الوضع المظلم',
                          value: _nightModeEnabled,
                          onChanged: (value) {
                            setState(() {
                              _nightModeEnabled = value;
                            });
                            // TODO: Implement theme switching
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Reminders Section
                    SettingsSection(
                      title: 'التذكير والتنبيهات',
                      children: [
                        SettingsToggleItem(
                          icon: Iconsax.notification_bing,
                          title: 'الإشعار عند التذكير',
                          subtitle: 'تفعيل التذكير',
                          value: _autoRemindersEnabled,
                          onChanged: (value) {
                            setState(() {
                              _autoRemindersEnabled = value;
                            });
                          },
                        ),
                        SettingsNavigationItem(
                          icon: Iconsax.volume_high,
                          title: 'نأثير صوتي',
                          subtitle: 'الصوت',
                          onTap: () {
                            // TODO: Navigate to sound settings
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // App Settings Section
                    SettingsSection(
                      title: '',
                      children: [
                        SettingsNavigationItem(
                          icon: Iconsax.share,
                          title: 'شارك التطبيق',
                          subtitle: '',
                          onTap: () {
                            // TODO: Implement share functionality
                          },
                        ),
                        SettingsNavigationItem(
                          icon: Iconsax.star,
                          title: 'قيمنا على المتجر',
                          subtitle: '',
                          onTap: () {
                            // TODO: Navigate to app store
                          },
                        ),
                        SettingsNavigationItem(
                          icon: Iconsax.info_circle,
                          title: 'عن التطبيق',
                          subtitle: '',
                          onTap: () {
                            // TODO: Navigate to about screen
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Version Info
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'الإصدار ١.٠.٠',
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
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
      bottomNavigationBar: const HomeBottomNavBar(initialIndex: 4),
    );
  }
}
