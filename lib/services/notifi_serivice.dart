import 'package:do_the_task/services/notification_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  late NotificationProvider notificationProvider;
  late bool notificationsEnabled;
  NotificationService(this.notificationProvider) {
    notificationsEnabled = notificationProvider.notificationsEnabled;
  }

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
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    if (!notificationProvider.notificationsEnabled) {
      return null;
    }
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  void enableNotifications() {
    notificationProvider.notificationsEnabled = true;
  }

  void disableNotifications() {
    notificationProvider.notificationsEnabled = false;
    cancelAllNotifications();
  }

  void cancelAllNotifications() {
    notificationsPlugin.cancelAll();
  }
}
