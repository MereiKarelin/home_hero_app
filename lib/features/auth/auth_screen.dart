import 'package:auto_route/auto_route.dart';
import 'package:datex/features/auth/bloc/auth_bloc.dart';
import 'package:datex/features/auth/check_code.dart';
import 'package:datex/features/core/auth_utils.dart';
import 'package:datex/features/core/d_alerts.dart';
import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/core/d_custom_button.dart';
import 'package:datex/features/core/d_custom_text_field.dart';
import 'package:datex/features/core/d_text_style.dart';
import 'package:datex/utils/app_router.gr.dart';
import 'package:datex/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  final String country; // 'kz', 'by', 'ru'
  final AuthType authType;
  final UserType userType;

  const AuthScreen({super.key, required this.country, required this.authType, required this.userType});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController number = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool get isFormFilled => name.text.isNotEmpty && number.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    name.addListener(_onFieldsChanged);
    if (widget.authType == AuthType.login) {
      name.text = 'default';
    }
    number.addListener(_onFieldsChanged);
  }

  @override
  void dispose() {
    name.removeListener(_onFieldsChanged);
    number.removeListener(_onFieldsChanged);
    name.dispose();
    number.dispose();
    super.dispose();
  }

  void _onFieldsChanged() {
    setState(() {});
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Пожалуйста, введите ФИО";
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Пожалуйста, введите номер телефона";
    }

    final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
    // print(digits);

    if (digits.startsWith('7')) {
      if (digits.length < 11) {
        return "Пожалуйста, введите валидный номер";
      }
    } else if (digits.startsWith('375')) {
      if (digits.length < 12) {
        return "Пожалуйста, введите валидный номер ";
      }
    } else {
      return "Данного региона нету в приложений";
    }

    return null;
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      final digits = number.text.replaceAll(RegExp(r'[^0-9]'), '');
      BlocUtils.authBloc.add(AuthCheckNumberEvent(number: "+$digits"));
    } else {
      // print("Форма невалидна.");
    }
  }

  @override
  Widget build(BuildContext context) {
    // В зависимости от страны можно менять маску:
    String hint;
    String mask;

    switch (widget.country) {
      case 'kz':
      case 'ru':
        hint = "+7 (___) ___-__-__";
        mask = '+7 (###) ###-##-##';
        break;
      case 'by':
        hint = "+375 (__) ___-__-__";
        mask = '+375 (##) ###-##-##';
        break;
      default:
        hint = "+7 (___) ___-__-__";
        mask = '+7 (###) ###-##-##';
    }

    return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthNumberInfoState) {
            if ((state.isNumberExist == false && widget.authType == AuthType.registration) ||
                (state.isNumberExist == true && widget.authType == AuthType.login)) {
              final digits = number.text.replaceAll(RegExp(r'[^0-9]'), '');
              showDialog(
                  context: context,
                  builder: (context) => CodeScreen(
                        name: name.text,
                        number: "+$digits",
                        userType: widget.userType,
                        authType: widget.authType,
                      ));
            } else {
              showDialog(
                  context: context,
                  builder: (context) => Dialog(
                        child: SizedBox(
                          height: 170,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                const Spacer(
                                  flex: 3,
                                ),
                                widget.authType == AuthType.registration ? const Text('Такой номер уже существует') : const Text('Такого номера не существует'),
                                const Spacer(
                                  flex: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'oк',
                                          style: DTextStyle.blueText,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
            }
          } else if (state is AuthErrorState) {
            DAlerts.showErrorAlert(state.error, context);
          } else if (state is AuthConfimedState) {
            DAlerts.showDefaultAlert(widget.authType == AuthType.login ? 'Вы успешно Авторизовались' : 'Вы успешно Зарегистрировались', () {
              Navigator.pop(context);
              AutoRouter.of(context).push(SplashRoute(isWelcomScreen: true));
            }, context);
          }
        },
        builder: (context, state) => Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(70),
                  child: SafeArea(
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              AutoRouter.of(context).maybePop();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.arrow_back_ios,
                                  color: DColor.blueColor,
                                  size: 20,
                                ),
                                Text(
                                  'Назад',
                                  style: DTextStyle.blueText.copyWith(fontSize: 15),
                                )
                              ],
                            ))
                      ],
                    ),
                  )),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Spacer(
                        flex: 3,
                      ),
                      SvgPicture.asset('assets/logo/app_icon.svg'),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.authType == AuthType.registration ? 'Регистрация' : 'Авторизация',
                        style: DTextStyle.boldBlackText.copyWith(fontSize: 28),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.authType == AuthType.registration
                          ? DCustomTextField(
                              label: 'ФИО',
                              hint: "Введите ФИО*",
                              controller: name,
                              onChanged: (value) {
                                setState(() {});
                              },
                              validator: _validateName,
                            )
                          : const SizedBox(),
                      const Spacer(
                        flex: 1,
                      ),
                      DCustomTextField(
                        label: "Номер телефона",
                        hint: hint,
                        mask: mask,
                        keyboardType: TextInputType.phone,
                        controller: number,
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: _validatePhone,
                      ),
                      const Spacer(
                        flex: 5,
                      ),
                      DCustomButton(
                          gradient: isFormFilled ? DColor.primaryGreenGradient : DColor.primaryGreenUnselectedGradient, text: 'Далее', onTap: _onSubmit),
                      const Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
