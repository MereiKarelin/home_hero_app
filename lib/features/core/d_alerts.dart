import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/core/d_text_style.dart';
import 'package:flutter/material.dart';

class DAlerts {
  static Future<void> showErrorAlert(String error, BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => Dialog(
              child: SizedBox(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      const Spacer(
                        flex: 3,
                      ),
                      const Icon(
                        Icons.error_outline_rounded,
                        color: DColor.redColor,
                        size: 40,
                      ),
                      const Spacer(
                        flex: 1,
                      ),
                      Text(error),
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

  static Future<void> showDefaultAlert(String text, Function() onTap, BuildContext context) {
    return showDialog(
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
                      Text(text),
                      const Spacer(
                        flex: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: onTap,
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
}
