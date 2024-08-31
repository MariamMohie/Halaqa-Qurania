import 'dart:convert';

import 'package:http/http.dart' as http;

class quran {
// get Quran list
  static Future<List<dynamic>> getQuranList() async {
    final response =
        await http.get(Uri.parse('https://api.alquran.cloud/v1/surah'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      final List<dynamic> quranList = data["data"] as List<dynamic>;
      // for (int i = 0; i < data.length; i++) {
      //   quranList.add({
      //     'id': data[i]['number'],
      //     'name': data[i]['name'],
      //     'englishName': data[i]['englishName'],
      //     'englishNameTranslation': data[i]['englishNameTranslation'],
      //     'revelationType': data[i]['revelationType'],
      //     'numberOfAyahs': data[i]['numberOfAyahs'],
      //   });
      // }
      return quranList;
    } else {
      throw Exception('Failed to load Quran list');
    }
  }

// get Surah
  static Future<List<dynamic>> getSurah(int id,String lang) async {
    final response =
        await http.get(Uri.parse('https://api.alquran.cloud/v1/surah/$id/$lang.asad'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      List<dynamic> surah = data['data']['ayahs'] as List<dynamic>;
      return surah;
    } else {
      throw Exception('Failed to load Surah');
    }
  }


  // get surah audio
  static Future<String> getSurahAudio(int id,int chapter_number) async {
    final response = await http.get(Uri.parse('https://api.quran.com/api/v4/chapter_recitations/$id/$chapter_number'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      final String audio = data['audio_file']['audio_url'] as String;
      return audio;
    } else {
      throw Exception('Failed to load Surah audio');
    }
  }

  // get reciters name
  static Future<List<dynamic>> getReciters(String lang) async {
    final response = await http.get(Uri.parse('https://api.quran.com/api/v4/resources/recitations?language=$lang'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      final List<dynamic> reciters = data['recitations'] as List<dynamic>;
      return reciters;
    } else {
      throw Exception('Failed to load Reciters');
    }
  }




// get ayah 
  static Future<List<ayahModel>> getAyah(String word) async {
    
    List<ayahModel> ayat = [];

    final response = await http.get(Uri.parse('https://api.alquran.cloud/v1/search/$word/all/ar'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      List<dynamic> matches = data['data']['matches'] as List<dynamic>;

      for (var matche in matches) {
        ayat.add(ayahModel(
          ayah: matche['text'],
          ayahnumber: matche['numberInSurah'],
          surahname: matche['surah']['name'],
          surahnumber: matche['surah']['number'],
        ));
      }
      return ayat;
    } else {
      throw Exception('Failed to load Ayah');
    }
  }
}

class ayahModel {
  
  String? ayah;
  int? ayahnumber;
  String? surahname;
  int? surahnumber;
  String? englishname;

  // constructor
  ayahModel({
    this.ayah,
    this.ayahnumber,
    this.surahname,
    this.surahnumber,
    this.englishname
  });
  
}