import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mihrap_app/features/hadith/presentation/screens/hadith_list_screen.dart';
import 'package:mihrap_app/features/home/presentation/widgets/home_bottom_nav_bar.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/services/hadith_service.dart';
import '../controller/cubit/hadith_cubit.dart';
import '../controller/cubit/hadith_state.dart';
import '../widgets/hadith_book_card.dart';
import 'hadith_detail_screen.dart';

class HadithBooksScreen extends StatelessWidget {
  const HadithBooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HadithCubit(HadithService())..loadBooks(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.bookmark,
                          color: AppColors.textOnLight,
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        'الأحاديث النبوية',
                        style: GoogleFonts.cairo(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.cardWhite,
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

                  const SizedBox(height: 24),

                  // Search Bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF151515),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(color: AppColors.textOnLight),
                      decoration: InputDecoration(
                        hintText: '...البحث في الكتب والأحاديث',
                        hintStyle: GoogleFonts.cairo(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        suffixIcon: const Icon(
                          Iconsax.search_normal,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // State handling with BlocBuilder
                  BlocBuilder<HadithCubit, HadithState>(
                    builder: (context, state) {
                      if (state is HadithLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.cardWhite,
                          ),
                        );
                      } else if (state is HadithError) {
                        return Center(
                          child: Text(
                            'خطأ في تحميل البيانات',
                            style: GoogleFonts.cairo(color: Colors.red),
                          ),
                        );
                      } else if (state is HadithBooksSuccess) {
                        return _buildContent(context, state);
                      }
                      return const SizedBox.shrink();
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: HomeBottomNavBar(initialIndex: 3),
      ),
    );
  }

  Widget _buildContent(BuildContext context, HadithBooksSuccess state) {
    final books = state.books;
    final randomHadith = state.randomHadith;

    // Helper map for Imam names
    final imamNames = {
      'bukhari': 'الإمام البخاري',
      'muslim': 'الإمام مسلم',
      'nasai': 'الإمام النسائي',
      'abudaud': 'الإمام أبو داود',
      'tirmidhi': 'الإمام الترمذي',
      'ibnumajah': 'الإمام ابن ماجه',
      'malik': 'الإمام مالك',
      'ahmad': 'الإمام أحمد',
      'darimi': 'الإمام الدارمي',
    };

    return Column(
      children: [
        // Books List Header with Count
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${books.length} كتب',
              style: GoogleFonts.cairo(
                fontSize: 14,
                color: AppColors.textSecondary.withOpacity(0.7),
              ),
            ),
            const Spacer(),
            Text(
              'كتب الحديث',
              style: GoogleFonts.cairo(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textOnLight,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: books.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final book = books[index];
            final bookId = book['id'] ?? '';
            return HadithBookCard(
              bookName: book['name'] ?? '',
              imamName: imamNames[bookId] ?? '',
              hadithCount: book['available']?.toString() ?? '0',
              iconInfo: index % 2 == 0 ? Iconsax.book_14 : Iconsax.book,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      HadithListScreen(bookTitle: book['name']),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        // Recent Read Header
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'تم قراءته مؤخراً',
            style: GoogleFonts.cairo(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Last Read Card
        if (randomHadith != null) _buildLastReadCard(context, randomHadith),
      ],
    );
  }

  Widget _buildLastReadCard(BuildContext context, Map<String, dynamic> hadith) {
    final content = hadith['content'] ?? '';
    final preview = content.length > 100
        ? '${content.substring(0, 100)}...'
        : content;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HadithDetailScreen(hadith: hadith),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.cardGray.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              '"$preview"',
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textOnLight.withOpacity(0.8),
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Iconsax.arrow_left_2,
                  color: AppColors.textSecondary,
                  size: 16,
                ),
                Text(
                  'رقم ${hadith['number']} - ${hadith['collectionName']}',
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'متابعة القراءة',
                  style: GoogleFonts.cairo(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textOnLight,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
