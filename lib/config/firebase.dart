import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/material.dart";

import "../firebase_options.dart";

abstract class FirebaseConfig {
  static const storageRoot = "sci-clubs-images";
  static const firestoreSciClubs = "sci_clubs";
  static const firestoreTags = "tags";
  static const departments = "departments";
}

Future<FirebaseApp> firebaseConfig() async {
  WidgetsFlutterBinding.ensureInitialized();
  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAuth.instance.setPersistence(Persistence.SESSION);
  return app;
}
