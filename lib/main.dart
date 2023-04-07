import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modyfikacja_aplikacja/app/app.dart';
import 'package:modyfikacja_aplikacja/app/injection_container.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(const MyApp());
}
