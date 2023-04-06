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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBjKQT8wdEf0ASwCk4RHmYtCd-R5MEQj6c',
    appId: '1:354457143091:web:85a695084c39194acca046',
    messagingSenderId: '354457143091',
    projectId: 'tiktok-clone-hoseon',
    authDomain: 'tiktok-clone-hoseon.firebaseapp.com',
    storageBucket: 'tiktok-clone-hoseon.appspot.com',
    measurementId: 'G-48SPBKCVCH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnxrV7rZVoU_TnCXZGqTItl7aBBM8E390',
    appId: '1:354457143091:android:16877a92f1ba544fcca046',
    messagingSenderId: '354457143091',
    projectId: 'tiktok-clone-hoseon',
    storageBucket: 'tiktok-clone-hoseon.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC0dLtX4e8Y6u6sEPE0YjnWuNfWp-46H5E',
    appId: '1:354457143091:ios:0a5c96fcc031debdcca046',
    messagingSenderId: '354457143091',
    projectId: 'tiktok-clone-hoseon',
    storageBucket: 'tiktok-clone-hoseon.appspot.com',
    iosClientId: '354457143091-q06kh85qb3lj7so7ubf1vq8hhk4oot47.apps.googleusercontent.com',
    iosBundleId: 'dev.hoseon.tiktokClone',
  );
}