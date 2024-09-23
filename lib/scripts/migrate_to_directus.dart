import "package:flutter/foundation.dart";
import "package:logger/logger.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../api_base/schema.graphql.dart";
import "directus_repository/directus_repository.dart";
import "migrate_to_firebase.dart";

part "migrate_to_directus.g.dart";

@riverpod
class MigrateToDirectus extends _$MigrateToDirectus {
  @override
  // ignore: prefer_void_to_null
  Null build() {
    return null;
  }

  Future<void> migrate() async {
    // Migrate data from Firebase to Directus
    // do not cover: departments and tags, logos and covers
    final directusTags = await ref.watch(directusRepositoryProvider.future);
    debugPrint("Directus tags: ${directusTags.map(
      (e) => {
        "id": e.id,
        "name": e.name,
      }.toString(),
    )}");

    final fireController = ref.watch(migrateToFirebaseProvider.notifier);
    final fireCollection = fireController.initFirestore();
    final sciClubs = await fireCollection.get();
    final directusRepo = ref.watch(directusRepositoryProvider.notifier);
    for (final sciClub in sciClubs.docs.take(3)) {
      final data = sciClub.data();
      if (data.id == null) {
        throw Exception("id is null");
      }
      Logger().w(
        "Migrating sciClub with id: ${data.id}",
      );
      final res = await directusRepo.updateSciClub(
        data.id!,
        Input$update_Scientific_Circles_input(
          name: data.name,
          description: data.description,
          shortDescription: data.shortDescription,
          source: data.toJson()["source"],
          type: data.toJson()["type"],
          links: [
            ...data.socialLinks.map(
              (e) => Input$update_Scientific_Circles_Links_input(
                id: e.id,
                link: e.url,
                name: e.name,
              ),
            ),
          ],
          useCoverAsPreviewPhoto: data.useCoverAsPreviewPhoto,
        ),
      );
      if (data.logo?.url != null ||
          data.cover?.url != null ||
          data.tags.isNotEmpty) {
        Logger().e(
          {
            "id": data.id,
            "logo": data.logo?.url,
            "cover": data.cover?.url,
            "tags": data.tags,
          }.toString(),
        );
      }
      Logger().i(
        res,
      );
    }
  }
}
