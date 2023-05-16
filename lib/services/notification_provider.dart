import 'package:do_the_task/services/notification_preference.dart';
import 'package:flutter/material.dart';

class NotificationProvider with ChangeNotifier {
  NotificationPreference notificationPreference = NotificationPreference();
  bool _notificationsEnabled = true;

  bool get notificationsEnabled => _notificationsEnabled;

  set notificationsEnabled(bool value) {
    _notificationsEnabled = value;
    notificationPreference.setNotificationStatus(value);
    notifyListeners();
  }

  Future<void> enableNotifications() async {
    _notificationsEnabled = true;
    await notificationPreference.setNotificationStatus(true);
    notifyListeners();
  }

  Future<void> disableNotifications() async {
    _notificationsEnabled = false;
    await notificationPreference.setNotificationStatus(false);
    notifyListeners();
  }
}
