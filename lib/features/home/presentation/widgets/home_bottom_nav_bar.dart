import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mihrap_app/core/constants/app_images.dart';
import 'package:mihrap_app/features/hadith/presentation/screens/hadith_books_screen.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../quran/presentation/screens/quran_home_screen.dart';
import '../../../tasbeeh/presentation/screens/tasbeeh_screen.dart';
import '../screens/home_screen.dart';

/// Bottom navigation bar widget - Exact Stitch Design
class HomeBottomNavBar extends StatefulWidget {
  final int initialIndex;

  const HomeBottomNavBar({super.key, this.initialIndex = 0});

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the appropriate screen
    switch (index) {
      case 0:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
        break;
      case 1:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const TasbeehScreen()),
        );
        break;
      case 2:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const QuranHomeScreen()),
        );
        break;
      case 3:
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HadithBooksScreen()),
        );
        break;
      case 4:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 0.5)),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: AppColors.background,
        elevation: 0,
        selectedItemColor: AppColors.cardWhite,
        unselectedItemColor: AppColors.textSecondary,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.cairo(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.cairo(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Iconsax.home),
            activeIcon: Icon(Iconsax.home_15),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImages.tasbeeh,
              width: 24,
              height: 24,
              color: AppColors.textSecondary,
            ),
            activeIcon: Image.asset(
              AppImages.tasbeeh,
              width: 26,
              height: 26,
              color: AppColors.cardWhite,
            ),
            label: 'المسبحة',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImages.koran,
              width: 24,
              height: 24,
              color: AppColors.textSecondary,
            ),
            activeIcon: Image.asset(
              AppImages.koran,
              width: 26,
              height: 26,
              color: AppColors.cardWhite,
            ),
            label: 'القرآن',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImages.hadith,
              width: 24,
              height: 24,
              color: AppColors.textSecondary,
            ),
            activeIcon: Image.asset(
              AppImages.hadith,
              width: 26,
              height: 26,
              color: AppColors.cardWhite,
            ),
            label: 'الأحاديث',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Iconsax.setting_2),
            activeIcon: Icon(Iconsax.setting),
            label: 'الإعدادات',
          ),
        ],
      ),
    );
  }
}
