import 'package:homehero/features/core/d_text_style.dart';
import 'package:homehero/features/core/d_webview_modal.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyWidget extends StatelessWidget {
  final Function() onTapFirst;
  final Function() onTapSecond;
  final bool firstValue;
  final bool secondValue;
  const PrivacyPolicyWidget({super.key, required this.onTapFirst, required this.onTapSecond, required this.firstValue, required this.secondValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: firstValue,
              onChanged: (value) {
                // Обработчик для первого чекбокса
                onTapFirst();
              },
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: DTextStyle.primaryText,
                  children: [
                    const TextSpan(text: 'Я ознакомлен '),
                    TextSpan(
                      text: 'Политикой конфиденциальности',
                      style: DTextStyle.urlText.copyWith(fontSize: 12),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // Для полного экрана
                            builder: (BuildContext context) {
                              return const DWebViewModal(
                                text: 'Политикой конфиденциальности',
                                url: 'https://policies.google.com/privacy?hl=ru', // URL для загрузки
                              );
                            },
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // const SizedBox(height: 10),
        Row(
          children: [
            Checkbox(
              value: secondValue,
              onChanged: (value) {
                // Обработчик для второго чекбокса
                onTapSecond();
              },
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                  style: DTextStyle.primaryText,
                  children: [
                    const TextSpan(text: 'Я ознакомлен '),
                    TextSpan(
                      text: 'Пользовательским соглашением',
                      style: DTextStyle.urlText.copyWith(fontSize: 12),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true, // Для полного экрана
                            builder: (BuildContext context) {
                              return const DWebViewModal(
                                text: 'Пользовательским соглашением',
                                url: 'https://policies.google.com/privacy?hl=ru', // URL для загрузки
                              );
                            },
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
