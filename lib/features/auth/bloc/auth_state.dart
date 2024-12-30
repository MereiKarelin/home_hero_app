part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthConfimedState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthNumberInfoState extends AuthState {
  final bool isNumberExist;
  AuthNumberInfoState({required this.isNumberExist});
}

final class AuthErrorState extends AuthState {
  final String error;
  AuthErrorState({required this.error});
}
