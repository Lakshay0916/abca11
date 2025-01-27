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
    apiKey: 'AIzaSyCWpqk00d4NpPv3UVonoaWG9zm8n8dMpUQ',
    appId: '1:869265678985:web:c88638a1b0386f5e3edc58',
    messagingSenderId: '869265678985',
    projectId: 'palm-book',
    authDomain: 'palm-book.firebaseapp.com',
    storageBucket: 'palm-book.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_n-2M1AO2BEY2kP7RoazY6NMZBT9pDkw',
    appId: '1:869265678985:android:7a620b061743ac653edc58',
    messagingSenderId: '869265678985',
    projectId: 'palm-book',
    storageBucket: 'palm-book.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3H_iZ536KqbTiZuCiO1KVDpHVk4pLOa0',
    appId: '1:869265678985:ios:e47dac03ca0f4a9d3edc58',
    messagingSenderId: '869265678985',
    projectId: 'palm-book',
    storageBucket: 'palm-book.appspot.com',
    iosClientId: '869265678985-ugqghd9m2hh8mlvtvciua1agoaqbb71i.apps.googleusercontent.com',
    iosBundleId: 'com.example.palmbook',
  );
}
