import "package:cloud_firestore/cloud_firestore.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/firebase.dart";
import "../models/tag.dart";

part "tags_repo.g.dart";

@Riverpod(keepAlive: true)
class TagsRepository extends _$TagsRepository {
  late final _collection = FirebaseFirestore.instance
      .collection(FirebaseConfig.firestoreTags)
      .withConverter<Tag>(
        fromFirestore: (snapshots, _) => Tag.fromJson(snapshots.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  @override
  FutureOr<List<Tag>> build() async {
    final data = await _collection.get();
    return data.docs.map((e) => e.data()).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }
}
