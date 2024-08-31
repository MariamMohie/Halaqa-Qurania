part of 'muslim_cubit.dart';

@immutable
sealed class MuslimState {}

final class MusilmInitial extends MuslimState {}
final class MusilmLoading extends MuslimState {}
final class MusilmFailed extends MuslimState {}
// quran list
final class QuranListLoading extends MuslimState {}
final class QuranListLoaded extends MuslimState {}
final class QuranListFailed extends MuslimState {}

// getsurah 
final class SurahLoading extends MuslimState {}
final class SurahLoaded extends MuslimState {}
final class SurahFailed extends MuslimState {}

// get surah audio
final class SurahAudioLoading extends MuslimState {}
final class SurahAudioLoaded extends MuslimState {}
final class SurahAudioFailed extends MuslimState {}

    
// get reciters
final class RecitersLoading extends MuslimState {}
final class RecitersLoaded extends MuslimState {}
final class RecitersFailed extends MuslimState {}

// get ayat
final class AyahLoading extends MuslimState {}
final class AyahLoaded extends MuslimState {}
final class AyahFailed extends MuslimState {}


// get hadith 
final class HadithLoading extends MuslimState {}
final class HadithLoaded extends MuslimState {}
final class HadithFailed extends MuslimState {}
