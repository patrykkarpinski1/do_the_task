import 'package:flutter/material.dart';
import 'package:modyfikacja_aplikacja/auth/start_page/start_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: getThemeData(),
      home: const StartPage(),
    );
  }

  ThemeData getThemeData() {
    return ThemeData(
      primarySwatch: Colors.blue,
    );
  }
}
