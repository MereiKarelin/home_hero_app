import 'package:auto_route/auto_route.dart';
import 'package:datex/features/core/auth_utils.dart';
import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/core/d_custom_button.dart';
import 'package:datex/features/unboarding/widgets/privacy_policy_widget.dart';
import 'package:datex/features/unboarding/widgets/unboarding_first_step.dart';
import 'package:datex/features/unboarding/widgets/unboarding_second_step.dart';
import 'package:datex/features/unboarding/widgets/unboarding_third_step.dart';
import 'package:datex/utils/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@RoutePage()
class UnboardingChooseScreen extends StatefulWidget {
  const UnboardingChooseScreen({super.key});

  @override
  State<UnboardingChooseScreen> createState() => _UnboardingChooseScreenState();
}

class _UnboardingChooseScreenState extends State<UnboardingChooseScreen> {
  int pageIndex = 0;

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
        ),
        UnboardingSecondStep(
          onTap: () => setState(() {
            pageIndex++;
          }),
        ),
        UnboardingThirdStep(
          onTap: () => setState(() {
            pageIndex++;
          }),
        ),
      ],
    ));
  }
}
