import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:islamic/core/theming/Colors.dart';
import 'package:islamic/features/Muslim_features/muslim_features/data/Doaa_model.dart';
import 'package:islamic/features/Muslim_features/muslim_features/data/hadith_model.dart';
import 'package:islamic/features/Muslim_features/muslim_features/data/quraan.dart';
import 'package:islamic/features/Muslim_features/muslim_features/data/zekr_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

part 'muslim_state.dart';

class MuslimCubit extends Cubit<MuslimState> {
  MuslimCubit() : super(MusilmInitial());
  List<Zeker_model> test =azkarElsabah;
  List<Zeker_model> Doaatest =DoaaQuraania_list;
  List<dynamic> surah = [];
   List<dynamic> surah2 = [];
   final player = AudioPlayer();
   String surahUrl = "";
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  List<dynamic> recitersarabic = [];
   
  String readingmood = "";
  int sizefont = 18;
  Color color = colorsClass.text;
  
  int cat_index=0;
  int tasbeh_count=0;
  int cat_index_doaa=0;
  List<String> hadith = [];
  int hadithindex = 0;

  List<ayahModel> ayat = [];


List<dynamic> quranlist = [];
   //! for Azkar 
  changeCategoryOfAzkar(int index){
    cat_index=index;
    if(index==0)
     test=azkarElsabah;
    else if(index ==1)
     test= azkarElmasaa;
    else if (index==2)
     test=aftarElsalah;
     else if(index==3)
       test=sleepingAzkar;
     else    test=azkarElsabah;
     emit(MusilmInitial());
  }

    increaseTasbehhCount(){
      tasbeh_count++;
      emit(MusilmInitial());

    }
    resetTasbehCount(){
      tasbeh_count=0;
      emit(MusilmInitial());
    }

    //! change for Doaa
    changeCategoryOfDoaa(int index){
    cat_index_doaa=index;
    if(index==0)
    Doaatest=DoaaQuraania_list;
    else if(index ==1)
    Doaatest= DoaaNaboia_list;
   
     emit(MusilmInitial());
  }
   getQuranList() async {
    emit(QuranListLoading());
    try {
      quranlist = await quran.getQuranList();
      emit(QuranListLoaded());
    } catch (e) {
      emit(QuranListFailed());
    }
  }

  // get surah
  getSurah(int id, String lang) async {
    emit(SurahLoading());
    try {
      surah = await quran.getSurah(id, lang);
      emit(SurahLoaded());
    } catch (e) {
      emit(SurahFailed());
    }
  }

  // set reading mood
  setReadingMood(String mood, int id) {
    emit(MusilmLoading());
    try {
      readingmood = mood;
      if (readingmood == 'arabic') {
        getSurah(id, 'ar');
      } else if (readingmood == 'english') {
        getSurah(id, 'en');
      } else {
        getSurahBoth(id);
      }
      emit(MusilmInitial());
    } catch (e) {
      emit(MusilmFailed());
    }
  }

  // font size
  setfontsize(int size) {
    emit(MusilmLoading());
    try {
      sizefont = size;
      emit(MusilmInitial());
    } catch (e) {
      emit(MusilmFailed());
    }
  }

   //! color
  setcolor(Color color) {
    emit(MusilmLoading());
    try {
      this.color = color;
      emit(MusilmInitial());
    } catch (e) {
      emit(MusilmFailed());
    }
  }

  //! get both languages
  getSurahBoth(int id) async {
    emit(SurahLoading());
    try {
      surah = await quran.getSurah(id, 'ar');
      surah2 = await quran.getSurah(id, 'en');

      emit(SurahLoaded());
    } catch (e) {
      emit(SurahFailed());
    }
  }

  // get surah audio
  getSurahAudio(int id, int chapter_number) async { 
    emit(SurahAudioLoading());
    try {
      surahUrl = await quran.getSurahAudio(id, chapter_number);
      duration = await player.setUrl(
        surahUrl,
      ) as Duration;

      player.durationStream.listen((duration0) {
        duration = duration0 as Duration;
      });

      player.positionStream.listen((position0) {
        position = position0 as Duration;
      });

      Timer.periodic(Duration(seconds: 1), (timer) {
        initial();
      });

      emit(SurahAudioLoaded());
    } catch (e) {
      emit(SurahAudioFailed());
    }
  }

  // initial
  initial() {
    player.durationStream.listen((duration0) {
      duration = duration0 as Duration;
    });

    player.positionStream.listen((position0) {
      position = position0 as Duration;
    });
    emit(SurahLoaded());
  }

  // get reciters
  getReciters() async {
    emit(RecitersLoading());
    try {
      recitersarabic = await quran.getReciters('ar');
      emit(RecitersLoaded());
    } catch (e) {
      emit(RecitersFailed());
    }
  }

  // get ahadith
  getHadith(String amamName, int index) async {
    emit(HadithLoading());
    try {
      hadith = await hadithApi.getHadith(amamName);
      hadithindex = index;
      emit(HadithLoaded());
    } catch (e) {
      emit(HadithFailed());
    }
  }

  // get ayat
  getAyah(String word) async {
    emit(AyahLoading());
    try {
      ayat = await quran.getAyah(word);
      emit(AyahLoaded());
      print(ayat[0].ayah);
      print(ayat.length);
    } catch (e) {
      emit(AyahFailed());
    }
  }

}
