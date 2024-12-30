import 'package:datex/features/core/d_text_style.dart';
import 'package:datex/features/core/d_webview_modal.dart';
import 'package:flutter/material.dart';

class CookieWidget extends StatelessWidget {
  final Function() onTap;
  final bool value;
  const CookieWidget({super.key, required this.onTap, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: value,
              onChanged: (value) {
                // Обработчик для первого чекбокса
                onTap();
              },
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, // Для полного экрана
                  builder: (BuildContext context) {
                    return const DWebViewModal(
                      text: 'Cookie',
                      url: 'https://policies.google.com/privacy?hl=ru', // URL для загрузки
                    );
                  },
                );
              },
              child: Text(
                'Я согласен на обработку файлов cookie',
                style: DTextStyle.urlText.copyWith(fontSize: 12),
              ),
            )
          ],
        ),
      ],
    );
  }
}
