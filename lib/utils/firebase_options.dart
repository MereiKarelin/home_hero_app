// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return windows;
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
    apiKey: 'AIzaSyB8WDZyjRim1J7OxBTfOv8tYEy4J2ZS9J0',
    appId: '1:779607642047:web:3ef58ebf909e89f9701b0a',
    messagingSenderId: '779607642047',
    projectId: 'homehero-1341d',
    authDomain: 'homehero-1341d.firebaseapp.com',
    storageBucket: 'homehero-1341d.firebasestorage.app',
    measurementId: 'G-W22F6NJNG4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBn7Btr0NUJwnj6cavcAmgW7nX4xbh31SY',
    appId: '1:779607642047:android:4128a01ab2de364c701b0a',
    messagingSenderId: '779607642047',
    projectId: 'homehero-1341d',
    storageBucket: 'homehero-1341d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDN_BAQ-yVYFIAui9SjiQoMRwm1iZTFYNI',
    appId: '1:779607642047:ios:cb6fc16c2ed41b85701b0a',
    messagingSenderId: '779607642047',
    projectId: 'homehero-1341d',
    storageBucket: 'homehero-1341d.firebasestorage.app',
    iosBundleId: 'com.homehero.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDN_BAQ-yVYFIAui9SjiQoMRwm1iZTFYNI',
    appId: '1:779607642047:ios:cb6fc16c2ed41b85701b0a',
    messagingSenderId: '779607642047',
    projectId: 'homehero-1341d',
    storageBucket: 'homehero-1341d.firebasestorage.app',
    iosBundleId: 'com.homehero.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB8WDZyjRim1J7OxBTfOv8tYEy4J2ZS9J0',
    appId: '1:779607642047:web:0514dac2b2bb29a5701b0a',
    messagingSenderId: '779607642047',
    projectId: 'homehero-1341d',
    authDomain: 'homehero-1341d.firebaseapp.com',
    storageBucket: 'homehero-1341d.firebasestorage.app',
    measurementId: 'G-9S2Q1YJWCJ',
  );
}
