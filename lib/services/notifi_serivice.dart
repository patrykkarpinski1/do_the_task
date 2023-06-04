import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_the_task/services/notification_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

import '../features/detalis/pages/detalis_task_page.dart';

@injectable
class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  late bool notificationsEnabled;
  final NotificationProvider notificationProvider;
  NotificationService(
    this.notificationProvider,
  ) {
    notificationsEnabled = notificationProvider.notificationsEnabled;
  }
  final FirebaseMessaging fcm = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('notification');
    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            ((int id, String? title, String? body, String? payload) async {}));

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse response) async {
      if (response.payload == 'local') {
      } else {
        String? taskId = response.payload;
        if (taskId != null) {
          Get.to(() => (DetalisTasksPage(id: taskId)));
        }
      }
    });
    setupPushNotifications();
  }

  Future<void> setupPushNotifications() async {
    await fcm.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showFirebaseNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        taskId: message.data['task_id'],
      );
    });

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['payload'] != 'local') {
        String? taskId = message.data['task_id'];
        if (taskId != null) {
          Get.to(() => (DetalisTasksPage(id: taskId)));
        }
      }
    });
  }

  static Future<void> _backgroundMessageHandler(RemoteMessage message) async {}

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          'channelId',
          'channelName',
          importance: Importance.max,
        ),
        iOS: DarwinNotificationDetails());
  }

  Future showFirebaseNotification({
    int id = 0,
    String? title,
    String? body,
    String? taskId,
  }) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await notificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
      payload: taskId ?? '',
    );
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    if (!notificationProvider.notificationsEnabled) {
      return null;
    }
    return notificationsPlugin.show(
      id,
      title,
      body,
      await notificationDetails(),
      payload: 'local',
    );
  }

  void enableNotifications() {
    notificationProvider.notificationsEnabled = true;
  }

  void disableNotifications() {
    notificationProvider.notificationsEnabled = false;

    cancelAllNotifications();
  }

  void enableFirebaseNotifications() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return;
    }
    FirebaseFirestore.instance.collection('users').doc(userId).update({
      'notificationsEnabled': true,
    });
  }

  void disableFirebaseNotifications() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return;
    }
    FirebaseFirestore.instance.collection('users').doc(userId).update({
      'notificationsEnabled': false,
    });
  }

  void cancelAllNotifications() {
    notificationsPlugin.cancelAll();
  }
}
