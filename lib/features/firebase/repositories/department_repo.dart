import "package:cloud_firestore/cloud_firestore.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../config/firebase.dart";
import "../models/department.dart";

part "department_repo.g.dart";

@Riverpod(keepAlive: true)
class DepartmentRepo extends _$DepartmentRepo {
  late final _collection = FirebaseFirestore.instance
      .collection(FirebaseConfig.departments)
      .withConverter<Department>(
        fromFirestore: (snapshots, _) => Department.fromJson(snapshots.data()!),
        toFirestore: (model, _) => model.toJson(),
      );

  @override
  FutureOr<IList<Department>> build() async {
    final data = await _collection.get();
    return data.docs.map((e) => e.data()).toIList().sort(
          (a, b) => a.extractIntFromStrCode().compareTo(
                b.extractIntFromStrCode(),
              ),
        );
  }
}
