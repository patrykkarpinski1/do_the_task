import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class NotificationPreference {
  static const notifiStatus = "NotificationStatus";

  Future<bool> getNotificationStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(notifiStatus) ?? true;
  }

  Future<void> setNotificationStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(notifiStatus, value);
  }
}
