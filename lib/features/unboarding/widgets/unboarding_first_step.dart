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
  UnboardingFirstStep({super.key, required this.onTap, this.authType, required this.onChangeAuthType});

  @override
  State<UnboardingFirstStep> createState() => _UnboardingChooseScreenState();
}

class _UnboardingChooseScreenState extends State<UnboardingFirstStep> {
  bool first = false;
  bool second = false;
  int pageIndex = 0;
  // AuthType? authType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/logo/app_icon.png'),
                  height: 120,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/unboarding_theme.png'),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
            PrivacyPolicyWidget(
              onTapFirst: () => setState(() {
                first = !first;
              }),
              onTapSecond: () => setState(() {
                second = !second;
              }),
              firstValue: first,
              secondValue: second,
            ),
            const Spacer(
              flex: 1,
            ),
            DCustomButton(
              gradient: first && second ? DColor.primaryGreenGradient : DColor.primaryGreenUnselectedGradient,
              text: 'Регистрация',
              onTap: () {
                if (first && second) {
                  // authType = AuthType.registration;
                  widget.onChangeAuthType(AuthType.registration);
                  widget.onTap();
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DCustomButton(
              color: first && second ? DColor.greyColor : DColor.greyUnselectedColor,
              text: 'Авторизация',
              onTap: () {
                if (first && second) {
                  // authType = AuthType.login;
                  widget.onChangeAuthType(AuthType.login);
                  widget.onTap();
                }
              },
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
