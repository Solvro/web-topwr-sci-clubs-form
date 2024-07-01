import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

import '../../firebase/models/uint8list_converter.dart';
import 'enums.dart';
import 'https_validator.dart';
import 'social_url_converter.dart';

part 'form_model.freezed.dart';
part 'form_model.g.dart';
part 'form_model.gform.dart';

@freezed
@Rf()
class SciClubFormModel with _$SciClubFormModel {
  const SciClubFormModel._();

  const factory SciClubFormModel({
    String? id,
    String? userId,
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
    @IgnoreConverter() @RfControl() Uint8List? logo,
    @IgnoreConverter() @RfControl() Uint8List? cover,
    @RfArray() List<bool>? tags,
    @SocialUrlConverter() @RfArray<SocialUrl>() List<SocialUrl>? socialLinks,
  }) = _SciClubFormModel;

  factory SciClubFormModel.fromJson(Map<String, Object?> json) =>
      _$SciClubFormModelFromJson(json);
}

@freezed
@RfGroup()
class SocialUrl with _$SocialUrl {
  const factory SocialUrl({
    @RfControl(validators: [
      RequiredValidator(),
      ComposeOrValidator(
        [
          HttpsValidator(),
          EmailValidator(),
        ],
      )
    ])
    String? url,
    @RfControl() String? name,
  }) = _SocialUrl;

  factory SocialUrl.fromJson(Map<String, Object?> json) =>
      _$SocialUrlFromJson(json);
}

extension IsEmail on SocialUrl {
  bool get isUrlEmail => (url ?? "").isUrlEmail;
}

extension IsEmailString on String {
  bool get isUrlEmail => EmailValidator.emailRegex.hasMatch(this);
}
