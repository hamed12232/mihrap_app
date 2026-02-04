import 'dart:convert';

import 'package:http/http.dart' as http;

class HadithService {
  // Singleton pattern
  static final HadithService _instance = HadithService._internal();
  factory HadithService() => _instance;
  HadithService._internal();

  static const String _baseUrl = 'https://api.hadith.gading.dev';

  /// Maps Arabic book titles to API slugs
  String _getBookSlug(String bookTitle) {
    if (bookTitle.contains('البخاري')) return 'bukhari';
    if (bookTitle.contains('مسلم')) return 'muslim';
    if (bookTitle.contains('النسائي')) return 'nasai';
    if (bookTitle.contains('أبي داود')) return 'abudaud';
    if (bookTitle.contains('الترمذي')) return 'tirmidhi';
    if (bookTitle.contains('ابن ماجه')) return 'ibnumajah';
    if (bookTitle.contains('مالك')) return 'malik';
    if (bookTitle.contains('أحمد')) return 'ahmad';
    if (bookTitle.contains('الدارمي')) return 'darimi';
    return 'bukhari'; // Default
  }

  /// Fetch hadiths based on the book title or slug.
  Future<List<Map<String, dynamic>>> getHadiths(
    String bookTitle, {
    int rangeStart = 1,
    int rangeEnd = 20,
  }) async {
    final slug = _getBookSlug(bookTitle);
    final url = Uri.parse('$_baseUrl/books/$slug?range=$rangeStart-$rangeEnd');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> hadithsJson = data['data']['hadiths'];

        return hadithsJson
            .map(
              (h) => {
                'collectionName': data['data']['name'],
                'number': h['number'],
                'content': h['arab'],
                'translation':
                    h['id'], // Indonesian translation provided by API
                'title': '${data['data']['name']} - حديث رقم ${h['number']}',
              },
            )
            .toList();
      } else {
        throw Exception('Failed to load hadiths: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching hadiths: $e');
      rethrow;
    }
  }

  /// Fetch all available books
  Future<List<Map<String, dynamic>>> getBooks() async {
    final url = Uri.parse('$_baseUrl/books');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return List<Map<String, dynamic>>.from(data['data']);
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      print('Error fetching books: $e');
      rethrow;
    }
  }

  /// Get a single random hadith (e.g., for Home Screen)
  Future<Map<String, dynamic>> getRandomHadith() async {
    // API doesn't have a direct random endpoint for all books easily,
    // so we get a small range from a popular book and pick one.
    final hadiths = await getHadiths('bukhari', rangeStart: 1, rangeEnd: 50);
    return (hadiths..shuffle()).first;
  }
}
