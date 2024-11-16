import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAjpu6mKwlppp_0EvwHz1pgdcgckqpCQoA",
            authDomain: "lawfirm-mobile-app.firebaseapp.com",
            projectId: "lawfirm-mobile-app",
            storageBucket: "lawfirm-mobile-app.firebasestorage.app",
            messagingSenderId: "145263649496",
            appId: "1:145263649496:web:bd1ca3ed3da27dc639adad",
            measurementId: "G-RJMNEMX76J"));
  } else {
    await Firebase.initializeApp();
  }
}
