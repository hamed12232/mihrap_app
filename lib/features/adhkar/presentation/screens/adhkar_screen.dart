import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../home/presentation/widgets/home_bottom_nav_bar.dart';
import '../cubit/adhkar_cubit.dart';
import '../cubit/adhkar_state.dart';
import '../widgets/adhkar_card.dart';
import '../widgets/adhkar_filter_chip.dart';

class AdhkarScreen extends StatelessWidget {
  const AdhkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdhkarCubit()..loadAdhkar(),
      child: const AdhkarScreenContent(),
    );
  }
}

class AdhkarScreenContent extends StatelessWidget {
  const AdhkarScreenContent({super.key});

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
                    'الأدعية والأذكار',
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Iconsax.search_normal,
                      color: AppColors.textPrimary,
                      size: 24,
                    ),
                    onPressed: () {
                      // TODO: Implement search
                    },
                  ),
                ],
              ),
            ),

            
            BlocBuilder<AdhkarCubit, AdhkarState>(
              builder: (context, state) {
                if (state is AdhkarLoaded) {
                  return Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      reverse: true, // RTL
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: AdhkarFilterChip(
                            label: category,
                            isSelected: state.selectedCategory == category,
                            onTap: () {
                              context.read<AdhkarCubit>().selectCategory(
                                category,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            const SizedBox(height: 16),

            // Content
            Expanded(
              child: BlocBuilder<AdhkarCubit, AdhkarState>(
                builder: (context, state) {
                  if (state is AdhkarLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.cardWhite,
                      ),
                    );
                  }

                  if (state is AdhkarError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.danger,
                            size: 48,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.cairo(
                              fontSize: 16,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<AdhkarCubit>().refresh();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.cardWhite,
                              foregroundColor: AppColors.textOnLight,
                            ),
                            child: Text(
                              'إعادة المحاولة',
                              style: GoogleFonts.cairo(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  if (state is AdhkarLoaded) {
                    final adhkarList = state.currentAdhkar;

                    if (adhkarList.isEmpty) {
                      return Center(
                        child: Text(
                          'لا توجد أذكار في هذه الفئة',
                          style: GoogleFonts.cairo(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: adhkarList.length,
                      itemBuilder: (context, index) {
                        final adhkar = adhkarList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: AdhkarCard(adhkar: adhkar),
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
      bottomNavigationBar: const HomeBottomNavBar(initialIndex: 0),
    );
  }
}
