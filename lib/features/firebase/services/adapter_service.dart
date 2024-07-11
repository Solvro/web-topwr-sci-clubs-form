import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../current_sci_club/models/url.dart';
import '../../form/model/form_model.dart';
import '../models/sci_club.dart';
import '../models/tag.dart';
import '../repositories/images_repo.dart';
import '../repositories/tags_repo.dart';

part 'adapter_service.g.dart';

class AdapterService {
  final Ref ref;

  const AdapterService(this.ref);

  Future<SciClub> fromFormToFirebase(SciClubFormModel model) async {
    final json = model.toJson();
    json["tags"] = await determineTagsFromBools(model).toList();
    json["id"] ??= const Uuid().v4();
    return SciClub.fromJson(json).copyWith(
      cover: model.cover == null || model.cover is! TempUrl
          ? model.cover
          : NormalUrl(
              await ImagesRepository.submitImage(
                model.cover as TempUrl,
                json["id"],
                "cover",
              ),
            ),
      logo: model.logo == null || model.logo is! TempUrl
          ? model.logo
          : NormalUrl(
              await ImagesRepository.submitImage(
                model.logo as TempUrl,
                json["id"],
                "logo",
              ),
            ),
    );
  }

  Future<SciClub> fromFormToLocal(SciClubFormModel model) async {
    final json = model.toJson();
    json["tags"] = await determineTagsFromBools(model).toList();
    return SciClub.fromJson(json).copyWith(
      cover: model.cover,
      logo: model.logo,
    );
  }

  Future<SciClubFormModel> fromFirebaseToForm(SciClub model) async {
    final json = model.toJson();
    json["tags"] = await determinBoolsFromTags(model).toList();
    return SciClubFormModel.fromJson(json)
        .copyWith(cover: model.cover, logo: model.logo);
  }

  Stream<String> determineTagsFromBools(SciClubFormModel model) async* {
    final tags = await ref.read(remoteTagsRepositoryProvider.future);
    for (final pair in IterableZip([tags, model.tags ?? []])) {
      if (pair.length >= 2) {
        final tagName = (pair.first as Tag).name;
        final isChosen = pair.last as bool;
        if (isChosen) {
          yield tagName;
        }
      }
    }
  }

  Stream<bool> determinBoolsFromTags(SciClub model) async* {
    final tags = await ref.read(remoteTagsRepositoryProvider.future);
    for (final tag in tags) {
      if (model.tags.contains(tag.name)) {
        yield true;
      } else {
        yield false;
      }
    }
  }

  // List<Map<String, dynamic>> serializeSocialLinks(List<SocialUrl> urls) {
  //   return urls.map((e) {
  //     if (e.isUrlEmail) {
  //       return SocialUrl(
  //         url: "mailto:${e.url}",
  //         name: e.url,
  //       );
  //     }
  //     return e;
  //   }).toList().;
  // }
}

@riverpod
AdapterService adapterService(AdapterServiceRef ref) {
  return AdapterService(ref);
}
