import "dart:typed_data";

import "package:firebase_storage/firebase_storage.dart";
import "package:http/http.dart" as http;

import "../../../config/firebase.dart";
import "../../current_sci_club/models/url.dart";

class ImagesRepository {
  static Reference get _collection =>
      FirebaseStorage.instance.ref().child(FirebaseConfig.storageRoot);

  static Future<String> submitImage(
    TempUrl image,
    String folder,
    String fileName,
  ) async {
    final ref = _collection.child(folder).child(fileName);
    await ref.putBlob(image.blob);
    // await ref.putData(image);
    return ref.getDownloadURL();
  }

  static Future<String> getUrl(String fileName) async {
    final ref = _collection.child(fileName);
    return ref.getDownloadURL();
  }

  static Future<Uint8List> downloadImage(AbstractUrl url) async {
    final response = await http.get(Uri.parse(url.url));
    return response.bodyBytes;
  }
}
