import "package:cloud_firestore/cloud_firestore.dart";
import "package:collection/collection.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/firebase.dart";
import "../../form/model/enums.dart" as enums;
import "../models/sci_club.dart";

part "sci_clubs_repo.g.dart";

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
    return data.docs.map((e) => e.data()).toList().sortBySourceTypes();
  }

  Future<void> save(SciClub model) async {
    if (model.id == null) {
      await _collection.add(model);
    } else {
      await _collection.doc(model.id).update(model.toJson());
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

extension IsSolvroX on SciClub {
  bool get isSolvro => name?.contains("Solvro") ?? false;
}

extension SortBySourceTypeX on Iterable<SciClub> {
  Iterable<SciClub> _filterByType(
    enums.Source source, {
    bool includeSolvro = false,
  }) {
    return where(
      (element) =>
          element.source == source && (includeSolvro || !element.isSolvro),
    );
  }

  List<SciClub> sortBySourceTypes() {
    final solvro = firstWhereOrNull((element) => element.isSolvro);
    final manualSource = _filterByType(enums.Source.manualEntry).toList()
      ..shuffle();
    final activeWebSource = _filterByType(enums.Source.aktywniWebsite).toList()
      ..shuffle();
    final studentDepartmentSource =
        _filterByType(enums.Source.studentDepartment).toList()..shuffle();

    return [
      if (solvro != null) solvro,
      ...manualSource,
      ...activeWebSource,
      ...studentDepartmentSource,
    ];
  }
}
