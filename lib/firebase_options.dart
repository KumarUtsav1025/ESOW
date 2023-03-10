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
    apiKey: 'AIzaSyAnJX2c1j68QpJIG-7wO--0SykNISdCZFo',
    appId: '1:814987701872:web:a2fdb28782d93296590eb5',
    messagingSenderId: '814987701872',
    projectId: 'esow-9bea7',
    authDomain: 'esow-9bea7.firebaseapp.com',
    storageBucket: 'esow-9bea7.appspot.com',
    measurementId: 'G-DD56HH1PR7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUl1CyILEiBJ_mkXPddK1vx130G5dLwtk',
    appId: '1:814987701872:android:137d3373afaeb4da590eb5',
    messagingSenderId: '814987701872',
    projectId: 'esow-9bea7',
    storageBucket: 'esow-9bea7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB78F6dQWwfW-2IPeYj1T-vpv2qyIMzVqM',
    appId: '1:814987701872:ios:be7a4012df4b4c30590eb5',
    messagingSenderId: '814987701872',
    projectId: 'esow-9bea7',
    storageBucket: 'esow-9bea7.appspot.com',
    iosClientId: '814987701872-qcpclrchjkbjovmfek4pnnfmcekiu4dv.apps.googleusercontent.com',
    iosBundleId: 'com.example.esos',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB78F6dQWwfW-2IPeYj1T-vpv2qyIMzVqM',
    appId: '1:814987701872:ios:be7a4012df4b4c30590eb5',
    messagingSenderId: '814987701872',
    projectId: 'esow-9bea7',
    storageBucket: 'esow-9bea7.appspot.com',
    iosClientId: '814987701872-qcpclrchjkbjovmfek4pnnfmcekiu4dv.apps.googleusercontent.com',
    iosBundleId: 'com.example.esos',
  );
}
