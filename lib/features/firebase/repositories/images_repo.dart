import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import '../../../config/firebase.dart';

class ImagesRepository {
  static Future<String> submitImage(Uint8List image, String fileName) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child(FirebaseConfig.storageRoot)
        .child(fileName);
    await ref.putData(image);
    return await ref.getDownloadURL();
  }
}
