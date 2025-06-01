// lib/utils/notification_service.dart

import 'dart:io';
// import 'package:datex/features/main/widgets/notify_count_widget.dart';
// import 'package:datex/utils/injectable/configurator.dart';
import 'package:homehero/features/main/bloc/main_bloc.dart';
import 'package:homehero/utils/bloc_utils.dart';
import 'package:homehero/utils/injectable/configurator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_app_badge/flutter_app_badge.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:datex/utils/bloc_utils.dart';
// import 'package:datex/features/main/bloc/main_bloc.dart';

class NotificationService {
  NotificationService._internal();
  static final NotificationService instance = NotificationService._internal();

  NotificationService();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  /// Инициализация плагина, каналов и прав
  Future<void> init() async {
    if (_initialized) return;

    // 1) Android 13+ permission
    if (Platform.isAndroid) {
      final status = await Permission.notification.request();
      if (status != PermissionStatus.granted) {
        print('🚫 Android: пользователь отклонил уведомления');
      }
    }

    // 2) Инициализация плагина
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    await _plugin.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
      onDidReceiveNotificationResponse: (_) {
        // сюда можно добавить логику по тапу
      },
    );

    // 3) Создаём Android-канал (Oreo+)
    const channel = AndroidNotificationChannel(
      'default_chanel',
      'Высокие приоритетные уведомления',
      importance: Importance.max,
      showBadge: true,
      sound: RawResourceAndroidNotificationSound('ntf_sound'),
      playSound: true,
    );
    await _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    // 4) iOS: удалённые пуши + отображение в foreground
    if (Platform.isIOS) {
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );
      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        print('🚫 iOS: пользователь отклонил уведомления');
      }
    }

    _initialized = true;
  }

  /// Получение FCM-токена (на iOS — после APNs)
  Future<String> getFcmToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print('🔑 FCM token: $token');
    return token ?? '';
  }

  /// Слушаем пуши в foreground (один вызов!)
  Future<void> listenToForeground() async {
    FirebaseMessaging.onMessage.listen((msg) async {
      print('🔔 Foreground message: ${msg.data}');

      if (sharedDb.getBool('notifications') ?? true) {
        await _showLocal((msg.notification?.title ?? msg.data['title']).toString().replaceAll('#', ''), (msg.notification?.body ?? msg.data['body']))
            .toString()
            .replaceAll('#', '');
      }
    });
  }

  /// Показываем локальное уведомление
  Future<void> _showLocal(String? title, String? body) async {
    if ((title?.isEmpty ?? true) && (body?.isEmpty ?? true)) return;

    // уникальный ID
    final id = DateTime.now().millisecondsSinceEpoch.remainder(100000);

    final androidDetails = AndroidNotificationDetails(
      'default_chanel',
      'Высокие приоритетные уведомления',
      channelDescription: 'ntf_sound',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('ntf_sound'),
    );
    final iosDetails = DarwinNotificationDetails(
      sound: 'ntf_sound.caf',
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    await _plugin.show(
      id,
      title,
      body,
      NotificationDetails(android: androidDetails, iOS: iosDetails),
    );

    // обновляем бейдж и счётчик
    // final current = notificationCountNotifier.value;
    // notificationCountNotifier.value = current + 1;
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setInt('notifiers', current + 1);
    // FlutterAppBadge.count(current + 1);

    // обновляем UI
    BlocUtils.mainBloc.add(MainStartEvent());
  }

  /// Сброс бейджа
  Future<void> clearBadge() async {
    // notificationCountNotifier.value = 0;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('notifiers', 0);
    // FlutterAppBadge.count(0);
  }
}
