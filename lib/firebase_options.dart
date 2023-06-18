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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyAHqFK6qMNZtdb5WvQOvNk_CwKej9l4prU',
    appId: '1:379321968808:web:eac51a2d86fad39a447a9d',
    messagingSenderId: '379321968808',
    projectId: 'dream-fashion-store',
    authDomain: 'dream-fashion-store.firebaseapp.com',
    storageBucket: 'dream-fashion-store.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCDFjghP4SY_dtmVBWm7WIA1m53Hi8hUFU',
    appId: '1:379321968808:android:85d06e556609c34b447a9d',
    messagingSenderId: '379321968808',
    projectId: 'dream-fashion-store',
    storageBucket: 'dream-fashion-store.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDnJkxZ3-YuZz-sB2cbg5uRzwnRGPy_vk',
    appId: '1:379321968808:ios:61a39f7a4d24c22e447a9d',
    messagingSenderId: '379321968808',
    projectId: 'dream-fashion-store',
    storageBucket: 'dream-fashion-store.appspot.com',
    iosBundleId: 'com.example.toDoAppUsingRestApi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBDnJkxZ3-YuZz-sB2cbg5uRzwnRGPy_vk',
    appId: '1:379321968808:ios:972f09205e4d3d8d447a9d',
    messagingSenderId: '379321968808',
    projectId: 'dream-fashion-store',
    storageBucket: 'dream-fashion-store.appspot.com',
    iosBundleId: 'com.example.toDoAppUsingRestApi.RunnerTests',
  );
}