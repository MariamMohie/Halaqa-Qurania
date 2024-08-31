part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

// states for signUp
final class SignUpLoading extends AuthState {}
final class SignUpLoaded extends AuthState {
   final String response;
  SignUpLoaded(this.response);
}
final class SignUpFailed extends AuthState {}

// states for signIn
final class SignInLoading extends AuthState {}
final class SignInLoaded extends AuthState {
  final String response;
  SignInLoaded(this.response);
}
final class SignInFailed extends AuthState {}


// states for forgetPassword
final class ForgetPasswordLoading extends AuthState {}
final class ForgetPasswordLoaded extends AuthState {
  final String response;
  ForgetPasswordLoaded(this.response);
}
final class ForgetPasswordFailed extends AuthState {}
 