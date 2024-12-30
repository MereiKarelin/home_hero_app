part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginEvent extends AuthEvent {
  final String number;
  AuthLoginEvent({required this.number});
}

final class AuthRegisterEvent extends AuthEvent {
  final String number;
  final String name;
  final UserType userType;
  AuthRegisterEvent({required this.number, required this.name, required this.userType});
}

final class AuthCheckNumberEvent extends AuthEvent {
  final String number;
  AuthCheckNumberEvent({required this.number});
}

final class AuthConfirmCodeEvent extends AuthEvent {
  final String number;
  final String code;
  final AuthType authType;
  AuthConfirmCodeEvent({required this.number, required this.code, required this.authType});
}
