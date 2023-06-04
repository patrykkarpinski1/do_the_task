import 'package:do_the_task/services/notifi_serivice.dart';
import 'package:do_the_task/services/notification_preference.dart';
import 'package:do_the_task/services/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '/app/app.dart';
import '/app/injection_container.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final notificationPreference = NotificationPreference();
  final notificationProvider = NotificationProvider(notificationPreference);
  NotificationService(notificationProvider).initNotification();
  configureDependencies();
  runApp(const MyApp());
}
