part of 'stream_cubit.dart';

@immutable
sealed class StreamState {}

final class StreamInitial extends StreamState {}

// create stream
final class StreamCreateLoading extends StreamState {}
final class StreamCreateLoaded extends StreamState {}
final class StreamCreateFailed extends StreamState {}
