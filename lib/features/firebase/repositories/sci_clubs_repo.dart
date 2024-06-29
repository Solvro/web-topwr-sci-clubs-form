import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/firebase.dart';
import '../models/sci_club.dart';

part 'sci_clubs_repo.g.dart';

@riverpod
class SciClubsRepo extends _$SciClubsRepo {
  late final _collection = FirebaseFirestore.instance
      .collection(FirebaseConfig.firestoreSciClubs)
      .withConverter<SciClub>(
        fromFirestore: (snapshots, _) =>
            SciClub.fromJson(snapshots.data()!).copyWith(
          id: snapshots.id,
        ),
        toFirestore: (model, _) => model.toJson(),
      );

  @override
  Future<List<SciClub>> build() async {
    final data = await _collection.get();
    return data.docs.map((e) => e.data()).toList();
  }

  Future<void> save(SciClub model) async {
    if (model.id == null) {
      await _collection.add(model);
    } else {
      _collection.doc(model.id).update(model.toJson());
    }
  }

  SciClub? getClub(String itemId) {
    return state.valueOrNull?.firstWhereOrNull(
      (element) => element.id == itemId,
    );
  }

  Future<SciClub?> getClubForUser(User user) async {
    final data = await future;
    return data.firstWhereOrNull((element) => element.userId == user.uid);
  }
}
