import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_model.g.dart';

part 'form_model.freezed.dart';

part 'form_model.gform.dart';

enum Source {
  manualEntry,
  aktywniWebsite,
  studentDepartment,
}

@freezed
@Rf()
class SciClubFormModel with _$SciClubFormModel {
  const factory SciClubFormModel({
    @RfControl(validators: [
      RequiredValidator(),
    ])
    String? name,
    @RfControl(validators: [
      RequiredValidator(),
    ])
    String? description,
    @RfControl(validators: [
      RequiredValidator(),
    ])
    String? shortDescription,
    @RfControl() String? type,
    Source? source,
    @RfControl(
      disabled: true,
    )
    String? department,
    @RfControl() Uint8List? logo,
    @RfControl() Uint8List? cover,
  }) = _SciClubFormModel;
}

@riverpod
SciClubFormModel sciClubFormModel(SciClubFormModelRef ref) {
  return const SciClubFormModel();
}
