// lib/features/auth/presentation/cubits/signup/signup_state.dart
part of 'signup_cubit.dart';

sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final UserEntity? user;
  final String message;
  final bool otpRequired;

  SignupSuccess({this.user, required this.message, this.otpRequired = false});
}

final class SignupFailure extends SignupState {
  final String message;

  SignupFailure({required this.message});
}
