import 'package:homehero/features/core/auth_utils.dart';
import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/core/d_custom_button.dart';
import 'package:homehero/features/core/d_text_style.dart';
import 'package:homehero/features/unboarding/widgets/cookie_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class UnboardingSecondStep extends StatefulWidget {
  AuthType? authType;
  final Function() onTap;
  String? selectedValue;
  final Function(String country) selectContry;
  UnboardingSecondStep({super.key, required this.onTap, this.authType, required this.selectContry});

  @override
  State<UnboardingSecondStep> createState() => _UnboardingChooseScreenState();
}

class _UnboardingChooseScreenState extends State<UnboardingSecondStep> {
  bool cookie = false;

  int pageIndex = 0;
  AuthType? authType;
  final List<Map<String, String>> items = [
    {
      'value': 'kz',
      'label': 'Казахстан',
      'icon': 'assets/flags/kz.png',
    },
    // {
    //   'value': 'ru',
    //   'label': 'Россия',
    //   'icon': 'assets/flags/ru.png',
    // },
    // {'value': 'by', 'label': 'Беларусь', 'icon': 'assets/flags/by.png'},
  ];

  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void toggleDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlay();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  OverlayEntry _createOverlay() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: MediaQuery.of(context).size.width - 32,
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: const Offset(0, 60), // Смещение выпадающего списка
            child: Material(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12), color: DColor.whiteColor, border: Border.all(color: DColor.greyUnselectedColor)),
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: items.map((item) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          widget.selectedValue = item['value'];
                        });
                        widget.selectContry(item['value'] ?? '');
                        toggleDropdown();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              Image.asset(
                                item['icon']!,
                                width: 28,
                                height: 28,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item['label']!,
                                style: DTextStyle.primaryText.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

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
            CompositedTransformTarget(
              link: _layerLink,
              child: GestureDetector(
                onTap: toggleDropdown,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: DColor.greyUnselectedColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.selectedValue != null)
                        Row(
                          children: [
                            Image.asset(
                              items.firstWhere((item) => item['value'] == widget.selectedValue)['icon']!,
                              width: 28,
                              height: 28,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              items.firstWhere((item) => item['value'] == widget.selectedValue)['label']!,
                              style: DTextStyle.primaryText.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ],
                        )
                      else
                        Text(
                          'Выберите регион*',
                          style: DTextStyle.primaryText.copyWith(fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 3,
            ),
            CookieWidget(
              onTap: () => setState(() {
                cookie = !cookie;
              }),
              value: cookie,
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
            const SizedBox(
              height: 10,
            ),
            DCustomButton(
              gradient: cookie && widget.selectedValue != null ? DColor.primaryGreenGradient : DColor.primaryGreenUnselectedGradient,
              text: 'Далее',
              onTap: () {
                if (cookie && widget.selectedValue != null) {
                  authType = AuthType.registration;
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
