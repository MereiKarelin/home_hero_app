import 'package:auto_route/auto_route.dart';
import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/core/d_custom_button.dart';
import 'package:datex/features/core/d_text_style.dart';
import 'package:datex/features/core/d_video_player.dart';
import 'package:datex/utils/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class UnboardingScreen extends StatefulWidget {
  const UnboardingScreen({super.key});

  @override
  State<UnboardingScreen> createState() => _UnboardingScreenState();
}

class _UnboardingScreenState extends State<UnboardingScreen> {
  int pageIndex = 1;
  bool showPreview = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pageIndex == 1
                  ? 'Роль ведущего'
                  : pageIndex == 2
                      ? 'Роль ведомого'
                      : 'Навигация по\nприложению',
              style: DTextStyle.boldBlackText.copyWith(fontSize: 28),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 175,
              child: Stack(
                children: [
                  if (pageIndex == 1 && !showPreview)
                    const DVideoPlayer(
                      filePath: 'assets/video/vedush.webm',
                      autoPlay: true,
                    ),
                  if (pageIndex == 2 && !showPreview)
                    const DVideoPlayer(
                      filePath: 'assets/video/vedom.webm',
                      autoPlay: true,
                    ),
                  if (pageIndex == 3)
                    SizedBox(
                      height: 175,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset('assets/logo/app_icon.svg'),
                          const SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              const url = 'https://www.youtube.com';
                              await launchUrl(Uri.parse(url));
                            },
                            child: const Text('Переход на сайт', style: DTextStyle.urlText),
                          ),
                        ],
                      ),
                    ),
                  if (pageIndex != 3)
                    InkWell(
                      onTap: () {
                        setState(() {
                          showPreview = false;
                        });
                      },
                      child: showPreview
                          ? SizedBox(
                              height: 175,
                              width: MediaQuery.of(context).size.width - 32,
                              child: pageIndex == 1
                                  ? FittedBox(fit: BoxFit.fill, child: Image.asset(fit: BoxFit.fill, 'assets/images/vedush.png'))
                                  : FittedBox(fit: BoxFit.fill, child: Image.asset(fit: BoxFit.fill, 'assets/images/vedom.png')))
                          : const SizedBox(),
                    ),
                ],
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 55),
        child: DCustomButton(
          gradient: DColor.primaryGreenGradient,
          text: 'Далее',
          onTap: () {
            if (pageIndex == 3) {
              AutoRouter.of(context).push(const UnboardingChooseRoute());
            } else {
              setState(() {
                pageIndex++;
                showPreview = true;
              });
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
