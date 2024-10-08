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
    apiKey: 'AIzaSyBgUW722TiNQ6Njal-OOFV-T7IU5ioMGVo',
    appId: '1:171846959174:android:167922b933cd2011a68a47',
    messagingSenderId: '171846959174',
    projectId: 'ready-artisans-c6a6e',
    storageBucket: 'ready-artisans-c6a6e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCv87ofykYaM8YhQOOYyBYnca04N59k9HY',
    appId: '1:28256255725:ios:089474e326465f865e96e4',
    messagingSenderId: '28256255725',
    projectId: 'ready-artisans',
    storageBucket: 'ready-artisans.appspot.com',
    iosClientId: '28256255725-0t99umadh49i6kgfavq49vvi60aqphot.apps.googleusercontent.com',
    iosBundleId: 'com.fihankra.readyArtisans',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD6-GbqAK0RD7cfDbf38ajmIUUHMNEEgk8',
    appId: '1:171846959174:web:a764226f4ac53b48a68a47',
    messagingSenderId: '171846959174',
    projectId: 'ready-artisans-c6a6e',
    authDomain: 'ready-artisans-c6a6e.firebaseapp.com',
    storageBucket: 'ready-artisans-c6a6e.appspot.com',
  );

}