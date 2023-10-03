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
    apiKey: 'AIzaSyAx5eTizzcI8YkEoE7FnFtqN926ry7ia1M',
    appId: '1:615896859487:android:f7eac3ed8623726a316cea',
    messagingSenderId: '615896859487',
    projectId: 'food-x-f1f5a',
    storageBucket: 'food-x-f1f5a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCAHzQ3lUqthr5LfTxaSqPgonie2cTFuk4',
    appId: '1:615896859487:ios:d4c0ff335b287c58316cea',
    messagingSenderId: '615896859487',
    projectId: 'food-x-f1f5a',
    storageBucket: 'food-x-f1f5a.appspot.com',
    androidClientId: '615896859487-s03fq298ad5kogsoem3nub60cca3ch90.apps.googleusercontent.com',
    iosClientId: '615896859487-oejvcf7dq4u6bj5iv0co83mofbnj5r9u.apps.googleusercontent.com',
    iosBundleId: 'com.example.foodx',
  );
}