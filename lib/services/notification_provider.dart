import 'package:do_the_task/services/notification_preference.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationProvider with ChangeNotifier {
  NotificationPreference notificationPreference;
  bool _notificationsEnabled = true;

  NotificationProvider(this.notificationPreference) {
    notificationPreference.getNotificationStatus().then((status) {
      _notificationsEnabled = status;
      notifyListeners();
    });
  }

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
