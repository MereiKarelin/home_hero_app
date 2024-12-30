import 'dart:async';

import 'package:datex/features/auth/bloc/auth_bloc.dart';
import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/main/bloc/main_bloc.dart';
import 'package:datex/utils/app_router.dart';
import 'package:datex/utils/injectable/configurator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      initializeDateFormatting('ru', null);
      await configureDependencies();
      runApp(MyApp());
    },
    (e, s) async {
      print(e.toString() + s.toString());
    },
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        // if (kDebugMode) {
        parent.print(zone, line);
        // }
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt.get<AuthBloc>(),
          ),
          BlocProvider(
            create: (context) => getIt.get<MainBloc>(),
          ),
        ],
        child: MaterialApp.router(
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
            textSelectionTheme: const TextSelectionThemeData(
                cursorColor: DColor.blueColor, // Задайте нужный цвет
                selectionHandleColor: DColor.blueColor),
            fontFamily: null,
          ),
          //  builder: (context, child) {

          // return SplashPage(child: child);
          // },
        ));
  }
}
