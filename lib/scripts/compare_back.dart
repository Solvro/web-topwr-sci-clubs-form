import "package:collection/collection.dart";
import "package:fast_immutable_collections/fast_immutable_collections.dart";
import "package:logger/logger.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../api_base/directus_assets_url.dart";
import "../utils/where_non_null_iterable.dart";
import "copied_desc.dart";
import "migrate_to_firebase.dart";
import "sci_clubs_repository/scientific_circles_repository.dart";

part "compare_back.g.dart";

@riverpod
class CompareBack extends _$CompareBack {
  @override
  // ignore: prefer_void_to_null
  Null build() {
    return null;
  }

  Future<void> compare() async {
    // Migrate data from Firebase to Directus
    // do not cover: departments and tags, logos and covers

    final fireController = ref.watch(migrateToFirebaseProvider.notifier);
    final fireCollection = fireController.initFirestore();
    final sciClubs = await fireCollection.get();
    final directusSciClubs =
        await ref.read(scientificCirclesRepositoryProvider.future) ?? [];

    var diffCount = 0;
    var nullCount = 0;

    for (final sciClub in sciClubs.docs) {
      final firebaseOne = sciClub.data();
      if (firebaseOne.id == null) {
        throw Exception("id is null");
      }
      final directusOne = directusSciClubs.firstWhereOrNull(
        (element) => element.id == firebaseOne.id,
      );
      if (directusOne == null) {
        Logger().e(
          "SciClub with id: ${firebaseOne.id} not found in Directus",
        );
        nullCount++;
        continue;
      }
      Logger().i(
        "Comparing sciClub with id: ${firebaseOne.id}",
      );
      final differences = {};
      if (directusOne.name != firebaseOne.name) {
        differences["name"] = {
          "firebase": firebaseOne.name,
          "directus": directusOne.name,
        };
      }

      if (directusOne.description?.trim() != firebaseOne.description?.trim() &&
          fixHtmlDesc(directusOne.description) != firebaseOne.description &&
          !skipDescCheck.contains(firebaseOne.id)) {
        differences["description"] = {
          "firebase": firebaseOne.description,
          "directus": directusOne.description,
        };
      }

      if (directusOne.shortDescription != firebaseOne.shortDescription) {
        differences["shortDescription"] = {
          "firebase": firebaseOne.shortDescription,
          "directus": directusOne.shortDescription,
        };
      }

      if (directusOne.cover?.filename_disk?.directusUrl !=
          firebaseOne.cover?.url) {
        differences["cover"] = {
          "firebase": firebaseOne.cover?.url,
          "directus": directusOne.cover?.filename_disk?.directusUrl,
        };
      }

      if (directusOne.logo?.filename_disk?.directusUrl !=
          firebaseOne.logo?.url) {
        differences["logo"] = {
          "firebase": firebaseOne.logo?.url,
          "directus": directusOne.logo?.filename_disk?.directusUrl,
        };
      }

      if (directusOne.department?.name != firebaseOne.department) {
        differences["department"] = {
          "firebase": firebaseOne.department,
          "directus": directusOne.department?.name,
        };
      }

      if (directusOne.tags?.whereNonNull
              .map((e) => e.Tags_id?.name.toLowerCase())
              .toISet() !=
          firebaseOne.tags.map((e) => e.toLowerCase()).toISet()) {
        differences["tags"] = {
          "firebase": firebaseOne.tags.toSet(),
          "directus":
              directusOne.tags.whereNonNull.map((e) => e.Tags_id?.name).toSet(),
        };
      }

      if (directusOne.links.whereNonNull
                  .map((e) => e.link?.replaceFirst("mailto:", ""))
                  .toISet() !=
              firebaseOne.socialLinks.map((e) => e.url).toISet() ||
          directusOne.links.whereNonNull.map((e) => e.name?.trim()).toISet() !=
              firebaseOne.socialLinks.map((e) => e.name?.trim()).toISet()) {
        differences["socialLinks"] = {
          "firebase": firebaseOne.socialLinks
              .map(
                (e) => {"url": e.url, "name": e.name},
              )
              .toSet(),
          "directus": directusOne.links.whereNonNull
              .map(
                (e) => {
                  "url": e.link?.replaceFirst("mailto:", ""),
                  "name": e.name,
                },
              )
              .toSet(),
        };
      }
      if (directusOne.type != firebaseOne.toJson()["type"]) {
        differences["type"] = {
          "firebase": {
            "type": firebaseOne.toJson()["type"],
          },
          "directus": {
            "type": directusOne.type,
          },
        };
      }
      if (directusOne.source != firebaseOne.toJson()["source"]) {
        differences["source"] = {
          "firebase": {
            "source": firebaseOne.toJson()["source"],
          },
          "directus": {
            "source": directusOne.source,
          },
        };
      }

      if (directusOne.useCoverAsPreviewPhoto !=
          firebaseOne.useCoverAsPreviewPhoto) {
        differences["useCoverAsPreviewPhoto"] = {
          "firebase": firebaseOne.useCoverAsPreviewPhoto,
          "directus": directusOne.useCoverAsPreviewPhoto,
        };
      }

      if (differences.isNotEmpty) {
        Logger().e(
          {
            "id": firebaseOne.id,
            ...differences,
          },
        );
        diffCount++;
      }
    }
    Logger().i("Total remaining differences: $diffCount");
    Logger().e("Total nulls: $nullCount");
  }
}
