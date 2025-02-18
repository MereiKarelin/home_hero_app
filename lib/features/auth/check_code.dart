import 'package:auto_route/auto_route.dart';
import 'package:homehero/features/auth/bloc/auth_bloc.dart';
import 'package:homehero/features/core/auth_utils.dart';
import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_custom_button.dart';
import 'package:homehero/features/core/d_text_style.dart';
import 'package:homehero/utils/app_router.gr.dart';
import 'package:homehero/utils/bloc_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CodeScreen extends StatefulWidget {
  final AuthType authType;
  final String number;
  final String name;
  final UserType userType;

  const CodeScreen({super.key, required this.authType, required this.number, required this.name, required this.userType});
  @override
  State<CodeScreen> createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {
  final TextEditingController _codeController = TextEditingController();
  final int codeLength = 6;
  bool taped = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: SafeArea(
            child: Row(
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Лого
              const SizedBox(
                height: 10,
              ),
              Image(
                image: AssetImage('assets/logo/app_icon.png'),
                height: 120,
              ),
              const Spacer(
                flex: 1,
              ),
              // Заголовок
              Text(
                widget.authType == AuthType.registration ? 'Регистрация' : 'Авторизация',
                style: DTextStyle.boldBlackText.copyWith(fontSize: 28),
              ),
              const SizedBox(
                height: 10,
              ),
              // Подзаголовок
              const Text(
                "Пожалуйста, введите полученный код*",
                style: DTextStyle.boldBlackText,
              ),
              const Spacer(
                flex: 1,
              ),

              // Поле для кода - отображаем квадраты с введёнными символами
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  // При тапе по области кода - фокус на текстовое поле
                  FocusScope.of(context).requestFocus(_focusNode);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(codeLength, (index) {
                    String digit = "";
                    if (_codeController.text.length > index) {
                      digit = _codeController.text[index];
                    }
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 42,
                      width: 42,
                      decoration: BoxDecoration(
                        gradient: digit.isNotEmpty || index == _codeController.text.length
                            ? DColor.primaryGreenGradient
                            : const LinearGradient(
                                colors: [DColor.unselectedColor, DColor.unselectedColor],
                              ),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Center(
                        child: Container(
                          // margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: DColor.unselectedColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            digit,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const Spacer(
                flex: 5,
              ),

              // Скрытое текстовое поле
              TextField(
                controller: _codeController,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                style: const TextStyle(color: Colors.transparent),
                // делаем текст невидимым
                cursorColor: Colors.transparent,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.transparent,
                ),

                onChanged: (value) {
                  if (value.length > codeLength) {
                    _codeController.text = value.substring(0, codeLength);
                    _codeController.selection = TextSelection.fromPosition(TextPosition(offset: _codeController.text.length));
                  }
                  if (_codeController.text.length == 6) {
                    BlocUtils.authBloc.add(AuthConfirmCodeEvent(number: widget.number, code: _codeController.text, authType: widget.authType));
                  }
                  setState(() {});
                },
              ),
              // const SizedBox(height: 40),
              const Spacer(
                flex: 3,
              ),

              // Кнопка "Получить код"
              DCustomButton(
                text: !taped ? 'Получить код' : 'Введите код',
                onTap: () {
                  if (!taped) {
                    widget.authType == AuthType.registration
                        ? BlocUtils.authBloc.add(AuthRegisterEvent(number: widget.number, name: widget.name, userType: widget.userType))
                        : BlocUtils.authBloc.add(AuthLoginEvent(number: widget.number));
                    setState(() {
                      taped = true;
                    });
                  }
                },
                gradient: !taped ? DColor.primaryGreenGradient : DColor.primaryGreenUnselectedGradient,
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FocusNode _focusNode = FocusNode();
}
