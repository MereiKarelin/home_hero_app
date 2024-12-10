import 'package:datex/features/splash/splash_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DATeX',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(13, 196, 48, 1),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: null, // Не используйте шрифт, который блокирует Material Icons
      ),
      home: const SplashPage(),
    );
  }
}
