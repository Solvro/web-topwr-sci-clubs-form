import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../current_sci_club/utils/temp_image_url.dart';
import '../models/tag.dart';
import '../repositories/tags_repo.dart';
import '../../form/model/form_model.dart';
import '../models/sci_club.dart';
import '../repositories/images_repo.dart';

part 'adapter_service.g.dart';

class AdapterService {
  final Ref ref;

  const AdapterService(this.ref);

  Future<SciClub> fromFormToFirebase(SciClubFormModel model) async {
    final json = model.toJson();
    if (model.logo != null) {
      json["logo"] = await ImagesRepository.submitImage(
        model.logo!,
        model.logoStorageName,
      );
    }
    if (model.cover != null) {
      json["cover"] = await ImagesRepository.submitImage(
        model.cover!,
        model.coverStorageName,
      );
    }
    json["tags"] = await determineTagsFromBools(model).toList();
    return SciClub.fromJson(json);
  }

  Future<SciClub> fromFormToLocal(SciClubFormModel model, String? id) async {
    final json = model.toJson();
    json["id"] = id;
    if (model.logo != null) {
      json["logo"] = TempImageUrl.createTemporaryUrl(model.logo!);
    }
    if (model.cover != null) {
      json["cover"] = TempImageUrl.createTemporaryUrl(model.cover!);
    }
    json["tags"] = await determineTagsFromBools(model).toList();
    return SciClub.fromJson(json);
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
}

@riverpod
AdapterService adapterService(AdapterServiceRef ref) {
  return AdapterService(ref);
}
