import 'package:equatable/equatable.dart';

abstract class HadithState extends Equatable {
  const HadithState();

  @override
  List<Object?> get props => [];
}

class HadithInitial extends HadithState {}

class HadithLoading extends HadithState {}

class HadithBooksSuccess extends HadithState {
  final List<Map<String, dynamic>> books;
  final Map<String, dynamic>? randomHadith;

  const HadithBooksSuccess({required this.books, this.randomHadith});

  @override
  List<Object?> get props => [books, randomHadith];
}

class HadithListSuccess extends HadithState {
  final List<Map<String, dynamic>> hadiths;
  final String collectionName;

  const HadithListSuccess({
    required this.hadiths,
    required this.collectionName,
  });

  @override
  List<Object?> get props => [hadiths, collectionName];
}

class HadithError extends HadithState {
  final String message;

  const HadithError(this.message);

  @override
  List<Object?> get props => [message];
}
