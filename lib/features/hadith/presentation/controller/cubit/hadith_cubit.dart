import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/services/hadith_service.dart';
import 'hadith_state.dart';

class HadithCubit extends Cubit<HadithState> {
  final HadithService _service;

  HadithCubit(this._service) : super(HadithInitial());

  Future<void> loadBooks() async {
    emit(HadithLoading());
    try {
      final books = await _service.getBooks();
      final random = await _service.getRandomHadith();
      emit(HadithBooksSuccess(books: books, randomHadith: random));
    } catch (e) {
      emit(HadithError(e.toString()));
    }
  }

  Future<void> loadHadiths(
    String bookTitle, {
    int rangeStart = 1,
    int rangeEnd = 20,
  }) async {
    emit(HadithLoading());
    try {
      final hadiths = await _service.getHadiths(
        bookTitle,
        rangeStart: rangeStart,
        rangeEnd: rangeEnd,
      );
      final collectionName = hadiths.isNotEmpty
          ? hadiths.first['collectionName']
          : bookTitle;
      emit(HadithListSuccess(hadiths: hadiths, collectionName: collectionName));
    } catch (e) {
      emit(HadithError(e.toString()));
    }
  }
}
