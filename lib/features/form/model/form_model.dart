import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_model.g.dart';

part 'form_model.freezed.dart';

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
    @RfControl() String? type,
    @RfControl() String? source,
    @RfControl() String? department,
    @RfControl() String? logo,
    @RfControl() String? cover,
  }) = _SciClubFormModel;

  factory SciClubFormModel.fromJson(Map<String, dynamic> json) =>
      _$SciClubFormModelFromJson(json);
}

@riverpod
SciClubFormModel sciClubFormModel(SciClubFormModelRef ref) {
  return const SciClubFormModel();
}
