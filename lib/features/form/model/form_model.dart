import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'enums.dart';

part 'form_model.freezed.dart';
part 'form_model.g.dart';
part 'form_model.gform.dart';

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
    @RfControl() SciClubType? type,
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
