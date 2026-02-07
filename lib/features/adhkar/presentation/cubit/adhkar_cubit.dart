import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/adhkar_service.dart';
import 'adhkar_state.dart';

class AdhkarCubit extends Cubit<AdhkarState> {
  AdhkarCubit() : super(AdhkarInitial());

  Future<void> loadAdhkar() async {
    try {
      emit(AdhkarLoading());

      final adhkarData = await AdhkarService.loadAdhkar();
      final categories = AdhkarService.getCategories(adhkarData);

      if (categories.isEmpty) {
        emit(AdhkarError('لا توجد بيانات أذكار'));
        return;
      }

      emit(
        AdhkarLoaded(
          adhkarData: adhkarData,
          categories: categories,
          selectedCategory: categories.first,
        ),
      );
    } catch (e) {
      emit(AdhkarError('حدث خطأ في تحميل الأذكار: $e'));
    }
  }

  void selectCategory(String category) {
    final currentState = state;
    if (currentState is AdhkarLoaded) {
      emit(currentState.copyWith(selectedCategory: category));
    }
  }

  void refresh() {
    loadAdhkar();
  }
}
