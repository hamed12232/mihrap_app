import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import '../models/adhkar_model.dart';

class AdhkarService {
  static Future<Map<String, List<AdhkarModel>>> loadAdhkar() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/adkar.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      final Map<String, List<AdhkarModel>> adhkarMap = {};

      jsonData.forEach((category, adhkarList) {
        if (adhkarList is List) {
          adhkarMap[category] = adhkarList
              .map((item) => AdhkarModel.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      });

      return adhkarMap;
    } catch (e) {
    log('Error loading adhkar: $e');
      return {};
    }
  }

  static List<String> getCategories(Map<String, List<AdhkarModel>> adhkarMap) {
    return adhkarMap.keys.toList();
  }
}
