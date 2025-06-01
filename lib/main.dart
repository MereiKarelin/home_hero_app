import 'dart:async';
import 'dart:math';

import 'package:homehero/features/auth/bloc/auth_bloc.dart';
import 'package:homehero/features/core/d_color.dart';
import 'package:homehero/features/event/bloc/event_bloc.dart';
import 'package:homehero/features/following/bloc/following_bloc.dart';
import 'package:homehero/features/main/bloc/main_bloc.dart';
import 'package:homehero/features/notification/bloc/notifications_bloc.dart';
import 'package:homehero/features/subscription/bloc/subscription_bloc.dart';
import 'package:homehero/utils/app_router.dart';
import 'package:homehero/utils/bloc_utils.dart';
import 'package:homehero/utils/firebase_options.dart';
import 'package:homehero/utils/firebase_service.dart';
import 'package:homehero/utils/injectable/configurator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> firebaseInit() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  _initializeFirebaseAndNotifications();
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 1) Инициализируем Flutter bindings, чтобы плагинам можно было пользоваться в фоне
  WidgetsFlutterBinding.ensureInitialized();

  // 2) Инициализируем Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 3) Инициализируем ваши зависимости (если нужны в фоне)
  await configureDependencies();
  final _random = Random();
  // 4) Получаем SharedPreferences и проверяем, включены ли у пользователя пуши
  final prefs = await SharedPreferences.getInstance();
  final enabled = prefs.getBool('notifications') ?? true;
  if (!enabled) return;

  // 5) Инициализируем плагин локальных уведомлений
  final plugin = FlutterLocalNotificationsPlugin();
  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  final iosInit = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );
  await plugin.initialize(
    InitializationSettings(android: androidInit, iOS: iosInit),
  );
  final id = _random.nextInt(100000);
  // 6) Создаём или получаем канал для Android
  const channel = AndroidNotificationChannel(
    'default_chanel',
    'high_priority_changel',
    // channelDescription: 'ntf_sound',
    importance: Importance.max,
    // priority: Priority.high,
    sound: RawResourceAndroidNotificationSound('ntf_sound'),
    showBadge: true,
    playSound: true,
  );
  await plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  // 7) Показываем локальное уведомление (при желании — можно убрать, если нужен silent push)
  await plugin.show(
    id,
    (message.notification?.title ?? message.data['title']).toString().replaceAll('#', ''),
    (message.notification?.body ?? message.data['body']).toString().replaceAll('#', ''),
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: 'ntf_sound',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('ntf_sound'),
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    ),
  );

  // 8) Инкрементируем счётчик уведомлений и сохраняем
  final currentCount = prefs.getInt('notifiers') ?? 0;
  final newCount = currentCount + 1;
  await prefs.setInt('notifiers', newCount);

  // 9) Обновляем локальный notifier (если вы его используете в UI)
  // notificationCountNotifier.value = newCount;

  // 10) Ставим бейдж на иконке через flutter_app_badger
  // FlutterAppBadge.count(newCount);
}

Future<void> _initializeFirebaseAndNotifications() async {
  // Request permissions for Firebase notifications
  // await _notificationService.();
  final NotificationService notificationService = NotificationService();
  await notificationService.init();
  await notificationService.listenToForeground();
  await notificationService.getFcmToken();

  // Start listening to foreground messages
}

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // initializeDateFormatting('ru', null);
      await initializeDateFormatting('ru_RU', null);
      await firebaseInit();
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addObserver(this);
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
          ),
          BlocProvider<NotificationsBloc>(
            create: (_) => BlocUtils.notificationsBloc,
            // lazy: false,
          ),
          BlocProvider<SubscriptionBloc>(
            create: (_) => BlocUtils.subscriptionBloc,
            // lazy: false,
          )
        ],
        child: MaterialApp.router(
          routerConfig: AppRouter().config(),
          theme: ThemeData(
            // теперь primarySwatch берём из DColor.primaryGreen
            primarySwatch: DColor.primaryGreen,
            // для accentColor, если нужно:
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: DColor.primaryGreen,
              accentColor: DColor.accentOrange,
            ),
            scaffoldBackgroundColor: Colors.white,
            checkboxTheme: CheckboxThemeData(
              checkColor: WidgetStateProperty.all(Colors.white),
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return DColor.greenColor; // Цвет фона чекбокса, когда он выбран
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
