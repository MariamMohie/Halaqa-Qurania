part of 'user_info_cubit.dart';

@immutable
sealed class UserInfoState {}

final class UserInfoInitial extends UserInfoState {}
// get cities
final class GetcitiesLoaded extends UserInfoState {}

final class GetcitiesLoading extends UserInfoState {}

final class GetcitiesFailed extends UserInfoState {}

// add userdata
final class SendUserDataLoaded extends UserInfoState {}

final class SendUserDataLoading extends UserInfoState {}

final class SendUserDataFailed extends UserInfoState {
  String? failed;
  SendUserDataFailed({this.failed});
}