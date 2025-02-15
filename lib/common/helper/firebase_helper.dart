import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return FirebaseOptions(
          apiKey: "AIzaSyDUxatLMM_QipNwheet5mBGJ0mmcul4JhU",
          authDomain: "testproject-c7109.firebaseapp.com",
          projectId: "testproject-c7109",
          storageBucket: "testproject-c7109.firebasestorage.app",
          messagingSenderId: "404023908359",
          appId: "1:404023908359:web:c5a609ef1b002c19c4f2a2",
          measurementId: "G-7XEDRJ70T6"
      );
    }
    return FirebaseOptions(
      apiKey: "AIzaSyAk4_8r4AGHihecHx81Apa6t2s_TXkEdkI",
      appId: "1:404023908359:android:98020dada66fd8f3c4f2a2",
      messagingSenderId: "404023908359",
      projectId: "testproject-c7109",
    );
  }
}