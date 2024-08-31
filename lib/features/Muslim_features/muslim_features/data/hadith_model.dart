import 'dart:convert';

import 'package:http/http.dart' as http;

List<String> hadithcategories = [
  "الإمام ابو داود",
  "الإمام احمد",
  "الإمام البخاري",
  "الإمام الترمذي",
  "الامام مسلم",
  "الامام النسائي"
];

List<String> hadithcategoriesApi = [
  "abu-dawud",
  "ahmad",
  "bukhari",
  "tirmidzi",
  "muslim",
  "nasai"
];


class hadithApi {
  static Future<List<String>> getHadith(String amamName) async {
    List<String> hadith = [];
    final response = await http.get(Uri.parse(
        'https://hadis-api-id.vercel.app/hadith/$amamName?page=1&limit=50'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      for (var item in data["items"]) {
        hadith.add(item["arab"]);        
      }
      

      return hadith;
    } else {
      throw Exception('Failed to load Hadith');
    }
  }
}
