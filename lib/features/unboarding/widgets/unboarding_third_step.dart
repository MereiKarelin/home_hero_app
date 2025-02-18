import 'package:homehero/features/core/auth_utils.dart';
import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_custom_button.dart';
import 'package:homehero/features/core/d_text_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class UnboardingThirdStep extends StatefulWidget {
  AuthType? authType;
  final Function() onTap;
  UnboardingThirdStep({super.key, required this.onTap, this.authType});

  @override
  State<UnboardingThirdStep> createState() => _UnboardingChooseScreenState();
}

class _UnboardingChooseScreenState extends State<UnboardingThirdStep> {
  final roles = [
    {'label': 'Ведущий', 'value': 'leader'},
    {'label': 'Ведомый', 'value': 'follower'},
  ];
  String? selectedRole;

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
              flex: 2,
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
            Text(
              'Выберите регион',
              style: DTextStyle.boldBlackText.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 12),
            ...roles.map((role) {
              final isSelected = selectedRole == role['value'];
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedRole = role['value'];
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.fromLTRB(7, 16, 12, 16),
                  decoration: BoxDecoration(
                    color: isSelected ? DColor.greenUnselectedColor : DColor.unselectedColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(role['label']!, style: DTextStyle.primaryText.copyWith(fontSize: 16, fontWeight: FontWeight.w500)),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? DColor.greyPrymaryColor : DColor.greyUnselectedColor,
                            width: 2,
                          ),
                          color: Colors.transparent,
                        ),
                        child: isSelected
                            ? Center(
                                child: Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: isSelected ? DColor.greyPrymaryColor : DColor.greyUnselectedColor,
                                ),
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            const Spacer(
              flex: 3,
            ),

            // const Spacer(
            //   flex: 1,
            // ),
            // DCustomButton(
            //   gradient: cookie ? DColor.primaryGreenGradient : DColor.primaryGreenUnselectedGradient,
            //   text: 'Далее',
            //   onTap: () {
            //     if (cookie) {
            //       authType = AuthType.registration;
            //       widget.onTap();
            //     }
            //   },
            // ),

            DCustomButton(
              gradient: selectedRole != null ? DColor.primaryGreenGradient : DColor.primaryGreenUnselectedGradient,
              text: 'Далее',
              onTap: () {
                if (selectedRole != null) {
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
