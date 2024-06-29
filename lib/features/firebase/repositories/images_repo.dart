import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../config/firebase.dart';
import '../../current_sci_club/models/url.dart';

class ImagesRepository {
  static Reference get _collection =>
      FirebaseStorage.instance.ref().child(FirebaseConfig.storageRoot);

  static Future<String> submitImage(Uint8List image, String fileName) async {
    final ref = _collection.child(fileName);
    await ref.putData(image);
    return await ref.getDownloadURL();
  }

  static Future<String> getUrl(String fileName) async {
    final ref = _collection.child(fileName);
    return await ref.getDownloadURL();
  }

  static Future<Uint8List> downloadImage(AbstractUrl url) async {
    final image = await Dio().get(
      url.url,
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(image.data);
  }
}
