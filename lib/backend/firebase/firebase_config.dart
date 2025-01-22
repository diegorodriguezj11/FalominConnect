import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyB5MOLqGhJ1fnEw_61_s3son5-b7T9jRbI",
            authDomain: "autobus-a6f93.firebaseapp.com",
            projectId: "autobus-a6f93",
            storageBucket: "autobus-a6f93.firebasestorage.app",
            messagingSenderId: "33687699637",
            appId: "1:33687699637:web:678a57689a70d8769dfefc",
            measurementId: "G-7QYKMB30Q1"));
  } else {
    await Firebase.initializeApp();
  }
}
