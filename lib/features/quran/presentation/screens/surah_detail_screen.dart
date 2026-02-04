import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran/quran.dart' as quran;

import '../../../../core/constants/app_colors.dart';
import '../widgets/surah_detail_bottom_bar.dart';
import '../widgets/surah_detail_header.dart';

class SurahDetailScreen extends StatefulWidget {
  final int surahNumber;

  const SurahDetailScreen({super.key, required this.surahNumber});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.black, // Deep black background for reading as per design
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            SurahDetailHeader(
              surahNumber: widget.surahNumber,
              onBack: () => Navigator.pop(context),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    // Bismillah
                    Text(
                      quran.basmala,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.amiri(
                        // Use Amiri or generic serif for now if font not loaded
                        fontSize: 24,
                        color: AppColors.cardWhite,
                        height: 2.0,
                      ),
                      // Ideally use an image or specific font for exact calligraphy match
                    ),
                    const SizedBox(height: 24),

                    // Verses
                    RichText(
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      text: TextSpan(
                        children: List.generate(
                          quran.getVerseCount(widget.surahNumber),
                          (index) {
                            return TextSpan(
                              children: [
                                TextSpan(
                                  text: quran.getVerse(
                                    widget.surahNumber,
                                    index + 1,
                                  ),
                                  style: GoogleFonts.amiri(
                                    fontSize: 22,
                                    color: AppColors.cardWhite,
                                    height: 2.2,
                                  ),
                                ),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.textSecondary,
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      '${index + 1}', // Simple verse number
                                      style: GoogleFonts.cairo(
                                        fontSize: 10,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    // ideally use quran.getVerseEndSymbol but it might render differently
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Bar
            SurahDetailBottomBar(
              onSaveProgress: () {
                // TODO: Save progress logic
              },
              onListen: () {
                // TODO: Listen logic
              },
              onTafseer: () {
                // TODO: Tafseer logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
