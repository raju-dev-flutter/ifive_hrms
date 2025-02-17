import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../core.dart';

class LocalNotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void requestNotificationPermission() async {
    // String? token = await messaging.getToken();
    // SharedPrefs.instance.setString(AppKeys.deviceToken, token.toString());
    // Logger().i(token.toString());
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User granted permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("User granted provisional permission");
    } else {
      debugPrint("User declined or has not accepted permission");
    }
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitialization =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInitialization = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitialization,
      iOS: iosInitialization,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handleMessage(context, message);
      },
    );
  }

  void firebaseInit(BuildContext context) async {
    FirebaseMessaging.onMessage.listen((message) {
      // debugPrint("Title: ${message.notification!.title}");
      // debugPrint("Body: ${message.notification!.body}");
      // debugPrint(": ${message.data[''].toString()}");
      if (Platform.isAndroid) {
        initLocalNotification(context, message);
        showNotification(message);
      } else {
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'ifive',
      'IFive Importance Notifications',
      importance: Importance.high,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      channelDescription: "",
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      ticker: 'ticket',
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    final id = DateTime.now().microsecondsSinceEpoch;
    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
        payload: 'IFive',
      );
    });
  }

  void setupInteractMessage(BuildContext context) async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(context, initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleMessage(context, message);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) async {
    if (message.data[''] != null) {
      debugPrint(message.data[''].toString());
      // navigatorKey.currentState?.push(MaterialPageRoute(
      //     builder: (context) => NotificationAlertScreen(
      //         bookingId: message.data['booking_id'].toString())));
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    SharedPrefs.instance.setString(AppKeys.deviceToken, token.toString());
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      debugPrint("Refresh");
    });
  }
}
