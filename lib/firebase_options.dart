// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      return web;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDx5AEb-jxfJEd-5CIidHz6qxMG5yo6Fj8',
    appId: '1:391289284118:web:9c7b30b9b3e95eb12d3737',
    messagingSenderId: '391289284118',
    projectId: 'smart-chef-7c8d6',
    authDomain: 'smart-chef-7c8d6.firebaseapp.com',
    storageBucket: 'smart-chef-7c8d6.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDK4gP_lo0aTiwjf5SvHZ79yijstMEn5Hw',
    appId: '1:391289284118:android:8d9bbf9511fe3da62d3737',
    messagingSenderId: '391289284118',
    projectId: 'smart-chef-7c8d6',
    storageBucket: 'smart-chef-7c8d6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8PyiVdPdyn0sE8GdII8Lu2O6_M2H2MZ8',
    appId: '1:391289284118:ios:5d5cf889fc262d3a2d3737',
    messagingSenderId: '391289284118',
    projectId: 'smart-chef-7c8d6',
    storageBucket: 'smart-chef-7c8d6.appspot.com',
    iosBundleId: 'com.example.smartchef',
  );
}