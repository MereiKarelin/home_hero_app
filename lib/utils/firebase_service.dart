import 'package:datex/features/notification/bloc/notifications_bloc.dart';
import 'package:datex/utils/bloc_utils.dart';
import 'package:datex/utils/injectable/configurator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationService() {
    _initializeLocalNotifications();
  }

  // Initialize the Flutter local notifications plugin
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    await _localNotificationsPlugin.initialize(initializationSettings);
  }

  Future<String> getFcmToken() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional) {
      final token = await FirebaseMessaging.instance.getToken();
      print(token);
      return token ?? '';
    } else {
      print('User declined or has not accepted permission');
    }
    return '';
  }

  // Show a local notification
  Future<void> showLocalNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    await _localNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformChannelSpecifics,
    );
  }

  // Request notification permissions for Firebase
  Future<void> requestFirebasePermissions() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission for Firebase notifications');
    } else {
      print('User declined Firebase notification permissions');
    }
  }

  // Listen for FCM messages when app is in foreground
  void listenToForegroundMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received message in foreground: ${message.data}');
      final notPer = sharedDb.getBool('notifications');
      if (notPer ?? false) {
        showLocalNotification(
          message.data["title"],
          message.data["body"],
        );
      }

      // BlocUtils.notificationsBloc.add(NotificationsFetched());
    });
  }
}
