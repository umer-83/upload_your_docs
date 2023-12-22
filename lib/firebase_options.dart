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
    apiKey: 'AIzaSyCvYzj5d0T0ZfVNqEJLtY8VN3vHb_mfFWE',
    appId: '1:879154468178:web:3754f48b33164354a3968b',
    messagingSenderId: '879154468178',
    projectId: 'uploadyourdocs-46380',
    authDomain: 'uploadyourdocs-46380.firebaseapp.com',
    storageBucket: 'uploadyourdocs-46380.appspot.com',
    measurementId: 'G-89JTRDJL99',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSCVNleVFrSv4ARuF-ttD7lo2ilaGwfO0',
    appId: '1:879154468178:android:48925a1e5ff43a57a3968b',
    messagingSenderId: '879154468178',
    projectId: 'uploadyourdocs-46380',
    storageBucket: 'uploadyourdocs-46380.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAGINRr4y-asHQIpWUD4x8nj0tUwioGU4',
    appId: '1:879154468178:ios:e8417abeb24edd2aa3968b',
    messagingSenderId: '879154468178',
    projectId: 'uploadyourdocs-46380',
    storageBucket: 'uploadyourdocs-46380.appspot.com',
    iosBundleId: 'com.example.uploadYourDocs',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAAGINRr4y-asHQIpWUD4x8nj0tUwioGU4',
    appId: '1:879154468178:ios:8d2fdd5fde9475c7a3968b',
    messagingSenderId: '879154468178',
    projectId: 'uploadyourdocs-46380',
    storageBucket: 'uploadyourdocs-46380.appspot.com',
    iosBundleId: 'com.example.uploadYourDocs.RunnerTests',
  );
}