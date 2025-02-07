import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:datex/domain/use_case/auth/check_number_use_case.dart';
import 'package:datex/domain/use_case/auth/confirm_code_use_case.dart';
import 'package:datex/domain/use_case/auth/login_use_case.dart';
import 'package:datex/domain/use_case/auth/register_use_case.dart';
import 'package:datex/features/core/auth_utils.dart';
import 'package:injectable/injectable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@Injectable()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegistrationUseCase registrationUseCase;
  final ConfirmCodeUseCase confirmCodeUseCase;
  final CheckNumberUseCase checkNumberUseCase;

  AuthBloc(this.loginUseCase, this.registrationUseCase, this.confirmCodeUseCase, this.checkNumberUseCase) : super(AuthInitial()) {
    // Register each event handler once
    on<AuthCheckNumberEvent>(_checkNumber);
    on<AuthRegisterEvent>(_authRegister);
    on<AuthLoginEvent>(_authLogin);
    on<AuthConfirmCodeEvent>(_confirmCode);
  }

  Future<void> _checkNumber(AuthCheckNumberEvent event, Emitter<AuthState> emit) async {
    try {
      final data = await checkNumberUseCase(CheckNumberUseCaseParams(number: event.number));
      emit(AuthNumberInfoState(isNumberExist: data));
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  Future<void> _authRegister(AuthRegisterEvent event, Emitter<AuthState> emit) async {
    try {
      await registrationUseCase(RegistrationUseCaseParams(number: event.number, name: event.name));
      // You may want to emit a state here if needed.
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  Future<void> _authLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    try {
      await loginUseCase(LoginUseCaseParams(number: event.number));
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  Future<void> _confirmCode(AuthConfirmCodeEvent event, Emitter<AuthState> emit) async {
    try {
      await confirmCodeUseCase(ConfirmCodeUseCaseParams(number: event.number, code: event.code, authType: event.authType));
      emit(AuthConfimedState());
    } catch (e) {
      emit(AuthErrorState(error: 'Неправильный код, пожалуйста введите правильный код'));
    }
  }
}
