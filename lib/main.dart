import 'package:datex/utils/app_router.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(13, 196, 48, 1),
        scaffoldBackgroundColor: Colors.white,
        checkboxTheme: CheckboxThemeData(
          checkColor: WidgetStateProperty.all(Colors.white),
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const Color.fromRGBO(13, 196, 48, 1); // Цвет фона чекбокса, когда он выбран
            }
            return Colors.white; // Цвет фона чекбокса, когда он не выбран
          }),
        ),
        fontFamily: null,
      ),
      //  builder: (context, child) {

      // return SplashPage(child: child);
      // },
    );
  }
}
