// ignore_for_file: avoid_print, depend_on_referenced_packages

import "dart:math";

import "package:collection/collection.dart";
import "package:dart_firebase_admin/auth.dart";
import "package:dart_firebase_admin/dart_firebase_admin.dart";
import "package:dart_firebase_admin/firestore.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "package:uuid/uuid.dart";

import "../api_base/directus_assets_url.dart";
import "../config/api_base_config.dart";
import "../config/firebase.dart";
import "../features/current_sci_club/models/url.dart";
import "../features/firebase/models/sci_club.dart";
import "../features/form/model/enums.dart";
import "../features/form/model/form_model.dart";
import "../features/navigation/utils/hex_converter.dart";
import "../utils/where_non_null_iterable.dart";
import "sci_clubs_repository/scientific_circles_repository.dart";

part "migrate_to_firebase.g.dart";

@riverpod
class MigrateToFirebase extends _$MigrateToFirebase {
  late Auth auth;

  @override
  Null build() {
    return null;
  }

  Future<void> removeAllUsers() async {
    final users = await auth.listUsers(maxResults: 300);
    final uids = users.users.map((user) => user.uid).toList();
    await auth.deleteUsers(uids);
  }

  CollectionReference<SciClub> initFirestore() {
    final admin = FirebaseAdminApp.initializeApp(
      ApiBaseEnv.firebaseName,
      Credential.fromServiceAccountParams(
        clientId: ApiBaseEnv.firebaseClientId,
        privateKey: ApiBaseEnv.firebasePrivateKey,
        email: ApiBaseEnv.firebaseEmail,
      ),
    );
    auth = Auth(admin);
    final firestore = Firestore(admin);
    return firestore
        .collection(FirebaseConfig.firestoreSciClubs)
        .withConverter<SciClub>(
          fromFirestore: (snapshots) =>
              SciClub.fromJson(snapshots.data()).copyWith(
            id: snapshots.id,
          ),
          toFirestore: (model) => model.toJson(),
        );
  }

  Future<void> migrate() async {
    final fireCollection = initFirestore();
    await removeAllUsers();
    final sciClubs = await ref.read(scientificCirclesRepositoryProvider.future);
    for (final sciClub in sciClubs.whereNonNull) {
      final model = await migrateUserAndModel(sciClub);
      if (model != null) await fireCollection.doc(sciClub.id).set(model);
    }
  }

  Future<SciClub?> migrateUserAndModel(ScientificCircle club) async {
    final email = club.links
        ?.firstWhereOrNull(
          (element) => element?.link?.startsWith("mailto:") ?? false,
        )
        ?.link
        ?.replaceFirst("mailto:", "");

    if (email != null) {
      print("${club.name} $email ");
      final user = await createUser(email, club.name);
      print("https://topwr-form.sharkserver.kowalinski.dev/${user.$2}");
      return fromFormToFirebase(user.$1, club);
    } else if (club.links?.isNotEmpty ?? false) {
      print("${club.links?[0]?.link} ");
      final user =
          await createUser("${generateWEPKey(6)}@kowalinski.dev", club.name);
      print(
        "${club.name} https://topwr-form.sharkserver.kowalinski.dev/${user.$2}",
      );
      return fromFormToFirebase(user.$1, club);
    } else {
      // print(club.name + club.links!.map((e) => e?.link).toString());
      return fromFormToFirebase(null, club);
    }
  }

  Future<SciClub> fromFormToFirebase(
    String? userId,
    ScientificCircle model,
  ) async {
    return SciClub(
      id: model.id,
      userId: userId,
      name: model.name,
      department: model.department?.name,
      tags: model.tags.whereNonNull.map((e) => e.Tags_id?.name ?? "").toList(),
      logo: model.logo?.filename_disk?.directusUrl == null
          ? null
          : NormalUrl(model.logo!.filename_disk!.directusUrl),
      cover: model.cover?.filename_disk?.directusUrl == null
          ? null
          : NormalUrl(model.cover!.filename_disk!.directusUrl),
      socialLinks: model.links.whereNonNull
          .map(
            (e) => SocialUrl(
              id: const Uuid().v4(),
              url: e.link,
              name: e.name,
            ),
          )
          .toList(),
      type: SciClubType.fromJsonVal(model.type),
      source: Source.fromJsonVal(model.source),
      description: fixHtmlDesc(model.description),
      shortDescription: model.shortDescription,
    );
  }

  Future<(String, String)> createUser(String email, String? display) async {
    final pass = generateWEPKey(64);
    final user = await auth.createUser(
      CreateRequest(
        email: email,
        password: pass,
        displayName: display,
        emailVerified: true,
        uid: generateWEPKey(12),
      ),
    );
    return (user.uid, "?1=${const HexConverter().toJson(email)}&2=$pass");
  }
}

Random random = Random.secure();

String generateWEPKey(int length) {
  const chars = "0123456789ABCDEF";
  return List.generate(length, (index) => chars[random.nextInt(16)]).join();
}

String? fixHtmlDesc(String? desc) {
  if (!(desc?.startsWith("<h1>") ?? false)) return "<p>$desc</p>";
  final items = desc
          ?.split(RegExp("<h1>|</h1>"))
          .where((str) => str.isNotEmpty)
          .toList() ??
      [];
  var results = "";
  for (var i = 0; i < items.length; i++) {
    if (i.isEven) {
      results += "<h1>${items[i]}</h1>";
    } else {
      results += "<p>${items[i]}</p>";
    }
  }
  return results == "" ? null : results;
}
