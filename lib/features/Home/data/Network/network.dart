import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:islamic/features/Muslim_features/muslim_features/data/quraan.dart';

Future<Map<String, String>> getAdan(String city, String country) async {
  final date = DateTime.now();
  final dateformat =
      "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}";

  final url = Uri.parse(
      "https://api.aladhan.com/v1/timingsByCity/$dateformat?city=$city&country=$country&method=8");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final time = data['data']['timings'] as Map<String, dynamic>;

    Map<String, String> Adan = {};

    Adan["Fajr"] = time["Fajr"];
    Adan["Sunrise"] = time["Sunrise"];
    Adan["Dhuhr"] = time["Dhuhr"];
    Adan["Asr"] = time["Asr"];
    Adan["Maghrib"] = time["Maghrib"];
    Adan["Isha"] = time["Isha"];


    return Adan;
  } else {
    throw Exception("Failed");
  }
  
}
// get Ayah

Future<ayahModel> getayah() async {
  final url = Uri.parse(
      "https://api.alquran.cloud/v1/ayah/${Random().nextInt(6235) + 1}/ar.asad");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    ayahModel ayah = ayahModel(
      ayah: data['data']['text'],
      ayahnumber: data['data']['surah']['numberOfAyahs'],
      surahname: data['data']['surah']['name'],
      surahnumber: data['data']['surah']['number'],
      englishname: data['data']['surah']['englishName']
    );
    

    return ayah;
  } else {
    throw Exception("Failed");
  }}