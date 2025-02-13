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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD1KDGeTHy69BD2w4hIPISm35ECkoJuaIs',
    appId: '1:807214650950:android:f16f36e41e5a8480df5c47',
    messagingSenderId: '807214650950',
    projectId: 'fresh-feed-app-fea4f',
    storageBucket: 'fresh-feed-app-fea4f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWY7Zl-0IlnqhzZ7Wt2HbVQOBQJCPH8Y8',
    appId: '1:807214650950:ios:1b4bb6db54f0a0d4df5c47',
    messagingSenderId: '807214650950',
    projectId: 'fresh-feed-app-fea4f',
    storageBucket: 'fresh-feed-app-fea4f.firebasestorage.app',
    androidClientId: '807214650950-9nd2k16fd1fnn9iame69p74f2a4dokjm.apps.googleusercontent.com',
    iosClientId: '807214650950-uf9pi2otfhs8mh9jjr74v8ojv46oihgt.apps.googleusercontent.com',
    iosBundleId: 'com.abohebil.freshFeed',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAVNDSirfXFWlnWAlEnaXtBuJzjyS8sZV8',
    appId: '1:807214650950:web:78bf0c590a58f993df5c47',
    messagingSenderId: '807214650950',
    projectId: 'fresh-feed-app-fea4f',
    authDomain: 'fresh-feed-app-fea4f.firebaseapp.com',
    storageBucket: 'fresh-feed-app-fea4f.firebasestorage.app',
  );

}