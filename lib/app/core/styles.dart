import 'package:flutter/material.dart';

enum Mode { color, dark }

class Styles {
  static Mode appMode = Mode.color;
  static ThemeData getThemeData() {
    if (appMode == Mode.color) {
      return ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color.fromARGB(255, 208, 225, 234),
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: Color.fromARGB(255, 29, 28, 28),
            ),
            bodyText2: TextStyle(
              color: Colors.white,
            ),
            button: TextStyle(color: Color.fromARGB(255, 208, 225, 234)),
          ),
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 29, 28, 28),
          ),
          cardColor: Colors.white,
          backgroundColor: Colors.white,
          bottomAppBarColor: Colors.indigo,
          focusColor: Colors.cyan,
          splashColor: const Color.fromARGB(255, 41, 117, 199));
    } else {
      return getDarkMode();
    }
  }

  static ThemeData getDarkMode() {
    return ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.white,
          ),
          bodyText2: TextStyle(
            color: Colors.grey,
          ),
          button: TextStyle(
            color: Colors.grey,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        cardColor: Colors.grey,
        backgroundColor: Colors.grey,
        bottomAppBarColor: Colors.black,
        focusColor: Colors.grey,
        splashColor: const Color.fromARGB(255, 34, 35, 36));
  }
}
