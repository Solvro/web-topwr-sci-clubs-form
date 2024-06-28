import 'package:cloud_firestore/cloud_firestore.dart';
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
    await _collection.add(model);
  }
}
