import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:homehero/features/core/d_text_style.dart';
import 'package:homehero/features/following/bloc/following_bloc.dart';
import 'package:homehero/features/main/bloc/main_bloc.dart';
import 'package:homehero/utils/app_router.gr.dart';
import 'package:homehero/utils/bloc_utils.dart';
import 'package:homehero/utils/injectable/configurator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  final bool? isWelcomScreen;
  const SplashPage({super.key, this.isWelcomScreen});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  VideoPlayerController? _controller;
  bool _visible = false;
  bool isLogined = false;

  @override
  void initState() {
    super.initState();
    isLogined = sharedDb.getString('token') != null;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    initVideo();

    if (mounted) {
      Future.delayed(const Duration(milliseconds: 3500), () {
        if (isLogined) {
          BlocUtils.mainBloc.add(MainStartEvent());
          BlocUtils.follofingBloc.add(GetFollowersEvent());
          AutoRouter.of(context).popAndPush(const MainRoute());
        } else {
          AutoRouter.of(context).popAndPush(const UnboardingChooseRoute());
        }

        // AutoRouter.of(context).replaceNamed(UnboardingRoute.name);
      });
    }
  }

  Future<void> initVideo() async {
    _controller = VideoPlayerController.asset("assets/video/splash.mp4");
    await _controller?.initialize();

    // _controller?.setLooping(true);
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _controller?.play();
        _visible = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller?.dispose();
      _controller = null;
    }
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      child: _controller != null ? VideoPlayer(_controller!) : const SizedBox(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: <Widget>[
            // SizedBox(height: MediaQuery.of(context).size.height,width: ,)
            _getVideoBackground(),
            if (widget.isWelcomScreen ?? false)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Добро пожаловать в\nассистент для сервиса',
                        style: DTextStyle.boldBlackText.copyWith(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 300,
                      ),
                    ],
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}
