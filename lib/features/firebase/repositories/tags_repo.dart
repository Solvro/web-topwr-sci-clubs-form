import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/firebase.dart';
import '../../../utils/watch_locale.dart';
import '../../../utils/where_non_null_iterable.dart';
import '../../topwr_mockup/features/sci_clubs_tab/repositories/getTags.graphql.dart';

part 'tags_repo.g.dart';

typedef Tag = Query$GetTags$Tags;

@riverpod
class RemoteTagsRepository extends _$RemoteTagsRepository {
  late final _collection = FirebaseFirestore.instance
      .collection(FirebaseConfig.firestoreTags)
      .withConverter<Tag>(
        fromFirestore: (snapshots, _) =>
            Tag(name: snapshots.data()?["name"] ?? ""),
        toFirestore: (model, _) => model.toJson(),
      );

  @override
  FutureOr<List<Tag>> build() async {
    final data = await _collection.get();
    return data.docs.map((e) => e.data()).toList();
  }
}

@riverpod
Tag allTagSingleton(AllTagSingletonRef ref) =>
    Tag(name: ref.watch(watchLocaleProvider).all);

@riverpod
Future<List<Tag>> tagsListRepository(TagsListRepositoryRef ref) async {
  final allTag = ref.watch(allTagSingletonProvider);
  final restTags = await ref.watch(remoteTagsRepositoryProvider.future);
  return [allTag, ...restTags.whereNonNull];
}
