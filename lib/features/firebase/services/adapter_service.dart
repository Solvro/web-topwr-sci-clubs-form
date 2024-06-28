import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    json["socialLinks"] = serializeSocialLinks(json["socialLinks"]);
    return SciClub.fromJson(json).copyWith(
      cover: model.cover == null
          ? null
          : NormalUrl(
              await ImagesRepository.submitImage(
                model.cover!,
                model.coverStorageName,
              ),
            ),
      logo: model.logo == null
          ? null
          : NormalUrl(
              await ImagesRepository.submitImage(
                model.logo!,
                model.logoStorageName,
              ),
            ),
    );
  }

  Future<SciClub> fromFormToLocal(SciClubFormModel model, String? id) async {
    final json = model.toJson();
    json["id"] = id;
    json["tags"] = await determineTagsFromBools(model).toList();
    json["socialLinks"] = serializeSocialLinks(json["socialLinks"]);
    return SciClub.fromJson(json).copyWith(
      cover: model.cover == null ? null : TempUrl.fromUint8List(model.cover!),
      logo: model.logo == null ? null : TempUrl.fromUint8List(model.logo!),
    );
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

  List<Map<String, dynamic>> serializeSocialLinks(List<SocialUrl> urls) {
    return urls.map((e) {
      if (e.isUrlEmail) {
        return SocialUrl(
          url: "mailto:${e.url}",
          name: e.url,
        ).toJson();
      }
      return e.toJson();
    }).toList();
  }
}

@riverpod
AdapterService adapterService(AdapterServiceRef ref) {
  return AdapterService(ref);
}
