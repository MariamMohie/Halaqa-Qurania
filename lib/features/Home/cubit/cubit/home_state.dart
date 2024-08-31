part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class AdanLoaded extends HomeState {}
final class AdanLoading extends HomeState {}


// ayah
final class AyahLoaded extends HomeState {}
final class AyahLoading extends HomeState {}



// lightmood

final class lightmoodLoaded extends HomeState {}

final class lightmoodLoading extends HomeState {}

