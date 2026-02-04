import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/services/hadith_service.dart';
import '../controller/cubit/hadith_cubit.dart';
import '../controller/cubit/hadith_state.dart';
import '../widgets/hadith_item_card.dart';
import 'hadith_detail_screen.dart';

class HadithListScreen extends StatefulWidget {
  final String bookTitle;

  const HadithListScreen({super.key, this.bookTitle = 'الأحاديث النبوية'});

  @override
  State<HadithListScreen> createState() => _HadithListScreenState();
}

class _HadithListScreenState extends State<HadithListScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['الكل', 'الأربعين النووية', 'صحيح البخاري'];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HadithCubit(HadithService())..loadHadiths(widget.bookTitle),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),

                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Iconsax.search_normal,
                        color: AppColors.textOnLight,
                      ),
                      onPressed: () {},
                    ),
                    Text(
                      'الأحاديث النبوية',
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

                const SizedBox(height: 24),

                // Filter Chips
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    itemCount: _filters.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final isSelected = _selectedFilterIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedFilterIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.cardWhite
                                : const Color(0xFF151515),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : AppColors.cardGray.withOpacity(0.5),
                            ),
                          ),
                          child: Text(
                            _filters[index],
                            style: GoogleFonts.cairo(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.black
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                // Hadith List with BlocBuilder
                Expanded(
                  child: BlocBuilder<HadithCubit, HadithState>(
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
                            'خطأ: ${state.message}',
                            style: GoogleFonts.cairo(color: Colors.red),
                          ),
                        );
                      } else if (state is HadithListSuccess) {
                        final hadiths = state.hadiths;
                        if (hadiths.isEmpty) {
                          return Center(
                            child: Text(
                              'لم يتم العثور على أحاديث',
                              style: GoogleFonts.cairo(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          );
                        }
                        return ListView.separated(
                          padding: const EdgeInsets.only(bottom: 24),
                          itemCount: hadiths.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final hadith = hadiths[index];
                            return HadithItemCard(
                              collectionName: hadith['collectionName'] ?? '',
                              title: hadith['title'] ?? '',
                              contentPreview: hadith['content'] ?? '',
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HadithDetailScreen(hadith: hadith),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
