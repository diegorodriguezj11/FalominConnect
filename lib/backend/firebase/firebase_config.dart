import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDFb1ev217OcKyC2gH_GdaR1fLDLwCvCoY",
            authDomain: "tienda-f7723.firebaseapp.com",
            projectId: "tienda-f7723",
            storageBucket: "tienda-f7723.appspot.com",
            messagingSenderId: "664899191021",
            appId: "1:664899191021:web:3b4b534afe85c0f1138ce4",
            measurementId: "G-D0T1SD920P"));
  } else {
    await Firebase.initializeApp();
  }
}
