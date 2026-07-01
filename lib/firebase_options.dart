import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;


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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDyMT8TrbVw4BQ6_Q2lSfa1QYuS8ZHhhec',
    appId: '1:28256255725:web:39234edc536ad0fc5e96e4',
    messagingSenderId: '28256255725',
    projectId: 'ready-artisans',
    authDomain: 'ready-artisans.firebaseapp.com',
    storageBucket: 'ready-artisans.appspot.com',
    measurementId: 'G-T3N7FCFRG8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC4vq_Ce0roy5XmHYEcOR-LgJxN7DG0-nc',
    appId: '1:28256255725:android:2e9077a0cd842af05e96e4',
    messagingSenderId: '28256255725',
    projectId: 'ready-artisans',
    storageBucket: 'ready-artisans.appspot.com',
  );
}
