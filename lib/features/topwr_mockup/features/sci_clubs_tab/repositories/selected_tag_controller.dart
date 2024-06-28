import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../firebase_tags/tags_repo.dart';

part 'selected_tag_controller.g.dart';

@riverpod
class SelectedTagController extends _$SelectedTagController {
  @override
  String? build() {
    return ref.watch(allTagSingletonProvider).name;
  }

  void handleTagSelected(Tag newValue) {
    state = newValue.name;
  }
}
