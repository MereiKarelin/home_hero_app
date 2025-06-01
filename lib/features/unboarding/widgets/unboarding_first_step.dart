import 'package:homehero/features/core/auth_utils.dart';
import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_custom_button.dart';
import 'package:homehero/features/unboarding/widgets/privacy_policy_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class UnboardingFirstStep extends StatefulWidget {
  AuthType? authType;
  final Function() onTap;
  final Function(AuthType authType) onChangeAuthType;
  UnboardingFirstStep({
    super.key,
    required this.onTap,
    this.authType,
    required this.onChangeAuthType,
  });

  @override
  State<UnboardingFirstStep> createState() => _UnboardingChooseScreenState();
}

class _UnboardingChooseScreenState extends State<UnboardingFirstStep> {
  bool first = false;
  bool second = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(90),
          child: Center(
            child: Image(
              image: AssetImage('assets/logo/app_icon.png'),
              height: 80,
            ),
          )),
      body: Column(
        children: [
          // Верхняя часть с картинкой, занимает 50% высоты экрана
          Expanded(
            flex: 2,
            child: Image.asset(
              'assets/images/unboarding_theme.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Нижняя часть с чекбоксами и кнопками, занимает оставшиеся 50%
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  PrivacyPolicyWidget(
                    onTapFirst: () => setState(() => first = !first),
                    onTapSecond: () => setState(() => second = !second),
                    firstValue: first,
                    secondValue: second,
                  ),

                  // Отступ между виджетами
                  const Spacer(),

                  // Кнопка «Регистрация»
                  DCustomButton(
                    gradient: first && second ? DColor.primaryGreenGradient : DColor.primaryGreenUnselectedGradient,
                    text: 'Регистрация',
                    onTap: () {
                      if (first && second) {
                        widget.onChangeAuthType(AuthType.registration);
                        widget.onTap();
                      }
                    },
                  ),

                  const SizedBox(height: 10),

                  // Кнопка «Авторизация»
                  DCustomButton(
                    color: first && second ? DColor.greyColor : DColor.greyUnselectedColor,
                    text: 'Авторизация',
                    onTap: () {
                      if (first && second) {
                        widget.onChangeAuthType(AuthType.login);
                        widget.onTap();
                      }
                    },
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
