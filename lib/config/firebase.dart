import 'package:firebase_core/firebase_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../firebase_options.dart';

part 'firebase.g.dart';

abstract class FirebaseConfig {
  static const storageRoot = "sci-clubs-images";
  static const firestoreSciClubs = "sci_clubs";
  static const firestoreTags = "tags";
}

@Riverpod(keepAlive: true)
Future<FirebaseApp> firebase(FirebaseRef ref) async {
  return await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
