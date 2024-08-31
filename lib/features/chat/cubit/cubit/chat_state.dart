part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}
// get users
final class ChatInitial extends ChatState {}
final class GetUserLoading extends ChatState {}
final class GetUserLoaded extends ChatState {}
final class GetUserFailed extends ChatState {}

// get audio
final class AudioLoading extends ChatState {}
final class AudioLoaded extends ChatState {}
final class AudioFailed extends ChatState {}


//get search
final class SearchLoading extends ChatState {}
final class SearchLoaded extends ChatState {}
final class SearchFailed extends ChatState {}