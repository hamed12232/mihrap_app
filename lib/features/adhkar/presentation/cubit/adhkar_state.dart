import '../../data/models/adhkar_model.dart';

abstract class AdhkarState {}

class AdhkarInitial extends AdhkarState {}

class AdhkarLoading extends AdhkarState {}

class AdhkarLoaded extends AdhkarState {
  final Map<String, List<AdhkarModel>> adhkarData;
  final List<String> categories;
  final String selectedCategory;

  AdhkarLoaded({
    required this.adhkarData,
    required this.categories,
    required this.selectedCategory,
  });

  List<AdhkarModel> get currentAdhkar {
    return adhkarData[selectedCategory] ?? [];
  }

  AdhkarLoaded copyWith({
    Map<String, List<AdhkarModel>>? adhkarData,
    List<String>? categories,
    String? selectedCategory,
  }) {
    return AdhkarLoaded(
      adhkarData: adhkarData ?? this.adhkarData,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class AdhkarError extends AdhkarState {
  final String message;

  AdhkarError(this.message);
}
