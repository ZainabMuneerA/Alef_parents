// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
   
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



  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCwF9wDQtsTaeKsO62v9Omve6xAOUUeVV8',
    appId: '1:514724677269:android:7590cec33391841d3afd9c',
    messagingSenderId: '514724677269',
    projectId: 'alef-229ac',
    storageBucket: 'alef-229ac.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBBFY35_Zw1WCet4-VlKDU3BhAiy9D5u24',
    appId: '1:514724677269:ios:6eb3bef7c6a9fdf93afd9c',
    messagingSenderId: '514724677269',
    projectId: 'alef-229ac',
    storageBucket: 'alef-229ac.appspot.com',
    iosClientId: '514724677269-pq92icdovonup1ban07a0o2qgeidijei.apps.googleusercontent.com',
    iosBundleId: 'com.example.alefParents',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBBFY35_Zw1WCet4-VlKDU3BhAiy9D5u24',
    appId: '1:514724677269:ios:ce0c1c1e7c8f71413afd9c',
    messagingSenderId: '514724677269',
    projectId: 'alef-229ac',
    storageBucket: 'alef-229ac.appspot.com',
    iosClientId: '514724677269-8hm7o7d6phenkg1rsoi7gf2po2d2ttso.apps.googleusercontent.com',
    iosBundleId: 'com.example.alefParents.RunnerTests',
  );
}
