import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:datex/utils/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  VideoPlayerController? _controller;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    _controller = VideoPlayerController.asset("assets/video/splash.mp4");
    _controller?.initialize().then((_) {
      // _controller?.setLooping(true);
      Timer(const Duration(milliseconds: 100), () {
        setState(() {
          _controller?.play();
          _visible = true;
        });
      });
    });
    if (mounted) {
      Future.delayed(const Duration(milliseconds: 3500), () {
        AutoRouter.of(context).popAndPush(const UnboardingRoute());
        // AutoRouter.of(context).replaceNamed(UnboardingRoute.name);
      });
    }
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
          children: <Widget>[
            _getVideoBackground(),
          ],
        ),
      ),
    );
  }
}
