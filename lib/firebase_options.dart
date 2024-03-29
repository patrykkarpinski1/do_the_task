// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBHgJB5VJDDDTezXgTLwFcq_X2fffJZ0QE',
    appId: '1:1016212216569:android:8e717d16ed1b45ce9be028',
    messagingSenderId: '1016212216569',
    projectId: 'modyfikacja-aplikacja',
    storageBucket: 'modyfikacja-aplikacja.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDng8hN07Sang_rE23A4hdQXTD6ntakoeY',
    appId: '1:1016212216569:ios:d37df3881c6d13fd9be028',
    messagingSenderId: '1016212216569',
    projectId: 'modyfikacja-aplikacja',
    storageBucket: 'modyfikacja-aplikacja.appspot.com',
    androidClientId: '1016212216569-e07ktpfrq8hmk8rj8nq4trss76d36onj.apps.googleusercontent.com',
    iosClientId: '1016212216569-ht3pomhpl0dscoj0m17p8mj8cf2mc7om.apps.googleusercontent.com',
    iosBundleId: 'com.patrykkarpinski.modyfikacjaAplikacja',
  );
}
