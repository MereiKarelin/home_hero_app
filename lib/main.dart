import 'dart:async';

import 'package:datex/features/auth/bloc/auth_bloc.dart';
import 'package:datex/features/core/d_color.dart';
import 'package:datex/features/event/bloc/event_bloc.dart';
import 'package:datex/features/following/bloc/following_bloc.dart';
import 'package:datex/features/main/bloc/main_bloc.dart';
import 'package:datex/utils/app_router.dart';
import 'package:datex/utils/bloc_utils.dart';
import 'package:datex/utils/firebase_service.dart';
import 'package:datex/utils/injectable/configurator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      initializeDateFormatting('ru', null);
      await Firebase.initializeApp();
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
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

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  // Настройка локальных уведомлений
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    channelDescription: 'your_channel_description',
    importance: Importance.max,
    priority: Priority.high,
  );

  const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0, // ID уведомления
    message.data['title'],
    message.data['data'],
    platformChannelSpecifics,
  );

  print('Фоновое сообщение обработано: ${message.notification?.title}');
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _initializeFirebaseAndNotifications();
    super.initState();
  }

  final NotificationService _notificationService = NotificationService();

  Future<void> _initializeFirebaseAndNotifications() async {
    // Request permissions for Firebase notifications
    // await _notificationService.();
    await _notificationService.getFcmToken();

    // Start listening to foreground messages
    _notificationService.listenToForegroundMessages();
  }

  // final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => BlocUtils.authBloc, // Ваш метод получения Bloc
            // lazy: false, // Инициализировать сразу, а не при первом использовании
          ),
          BlocProvider<MainBloc>(
            create: (_) => BlocUtils.mainBloc,
            // lazy: false,
          ),
          BlocProvider<EventBloc>(
            create: (_) => BlocUtils.eventBloc,
            // lazy: false,
          ),
          BlocProvider<FollowingBloc>(
            create: (_) => BlocUtils.follofingBloc,
            // lazy: false,
          )
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter().config(),
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
