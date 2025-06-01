import 'package:auto_route/auto_route.dart';
import 'package:homehero/features/core/auth_utils.dart';
import 'package:homehero/features/unboarding/widgets/unboarding_first_step.dart';
import 'package:homehero/features/unboarding/widgets/unboarding_second_step.dart';
import 'package:homehero/features/unboarding/widgets/unboarding_third_step.dart';
import 'package:homehero/utils/app_router.gr.dart';
import 'package:flutter/material.dart';

@RoutePage()
class UnboardingChooseScreen extends StatefulWidget {
  const UnboardingChooseScreen({super.key});

  @override
  State<UnboardingChooseScreen> createState() => _UnboardingChooseScreenState();
}

class _UnboardingChooseScreenState extends State<UnboardingChooseScreen> {
  int pageIndex = 0;
  String selectedCountry = '';
  AuthType? authType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
      index: pageIndex,
      children: [
        UnboardingFirstStep(
          onTap: () => setState(() {
            pageIndex++;
          }),
          onChangeAuthType: (AuthType authTypeVal) {
            authType = authTypeVal;
          },
        ),
        UnboardingSecondStep(
          selectContry: (country) {
            selectedCountry = country;
          },
          onTap: () => setState(() {
            pageIndex++;
          }),
        ),
        UnboardingThirdStep(
          onTap: (UserType userType) => setState(() {
            AutoRouter.of(context).push(AuthRoute(country: selectedCountry, userType: userType, authType: authType ?? AuthType.registration));
          }),
        ),
      ],
    ));
  }
}
