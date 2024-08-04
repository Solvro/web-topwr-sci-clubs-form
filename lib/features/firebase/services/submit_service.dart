import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../form/model/enums.dart";
import "../../form/model/form_model.dart";
import "../repositories/sci_clubs_repo.dart";
import "adapter_service.dart";

part "submit_service.g.dart";

class SubmitService {
  final Ref ref;

  SubmitService(this.ref);

  Future<void> submitSciClub(SciClubFormModel sciClub) async {
    final adapter = ref.read(adapterServiceProvider);
    final model = (await adapter.fromFormToFirebase(sciClub))
        .copyWith(source: Source.manualEntry);
    final repo = ref.read(sciClubsRepoProvider.notifier);
    await repo.save(model);
  }
}

@riverpod
SubmitService submitService(SubmitServiceRef ref) {
  return SubmitService(ref);
}
