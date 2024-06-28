import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../firebase/models/uint8list_converter.dart';
import 'enums.dart';

part 'form_model.freezed.dart';
part 'form_model.g.dart';
part 'form_model.gform.dart';

@freezed
@Rf()
class SciClubFormModel with _$SciClubFormModel {
  const SciClubFormModel._();

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
    @RfControl(validators: [
      RequiredValidator(),
    ])
    SciClubType? type,
    Source? source,
    @RfControl(
      disabled: true,
    )
    String? department,
    @Uint8ListConverter() @RfControl() Uint8List? logo,
    @Uint8ListConverter() @RfControl() Uint8List? cover,
    @RfArray() List<bool>? tags,
    @RfArray<SocialUrl>() List<SocialUrl>? socialLinks,
  }) = _SciClubFormModel;

  factory SciClubFormModel.fromJson(Map<String, Object?> json) =>
      _$SciClubFormModelFromJson(json);

  String get coverStorageName => "${name}_logo_$hashCode";
  String get logoStorageName => "${name}_cover_$hashCode";
}

@freezed
@RfGroup()
class SocialUrl with _$SocialUrl {
  const factory SocialUrl({
    @RfControl() String? name,
    @RfControl(validators: [
      RequiredValidator(),
      ComposeOrValidator([
        EmailValidator(),
      ])
    ])
    String? url,
  }) = _SocialUrl;

  factory SocialUrl.fromJson(Map<String, Object?> json) =>
      _$SocialUrlFromJson(json);
}

extension IsEmail on SocialUrl {
  bool get isUrlEmail => EmailValidator.emailRegex.hasMatch(url ?? "");
}
