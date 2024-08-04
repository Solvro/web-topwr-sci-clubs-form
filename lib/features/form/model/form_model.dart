import "package:freezed_annotation/freezed_annotation.dart";
import "package:reactive_forms_annotations/reactive_forms_annotations.dart";
import "package:uuid/uuid.dart";

import "../../current_sci_club/models/url.dart";
import "../../firebase/models/uint8list_converter.dart";
import "enums.dart";
import "https_validator.dart";
import "social_url_converter.dart";

part "form_model.freezed.dart";
part "form_model.g.dart";
part "form_model.gform.dart";

@freezed
@Rf()
class SciClubFormModel with _$SciClubFormModel {
  const factory SciClubFormModel({
    String? id,
    String? userId,
    @RfControl(
      validators: [
        RequiredValidator(),
      ],
    )
    String? name,
    @RfControl(
      validators: [
        RequiredValidator(),
      ],
    )
    String? description,
    @RfControl(
      validators: [
        RequiredValidator(),
      ],
    )
    String? shortDescription,
    @RfControl(
      validators: [
        RequiredValidator(),
      ],
    )
    SciClubType? type,
    Source? source,
    @RfControl(
      disabled: true,
    )
    String? department,
    @UrlConverter() @RfControl() AbstractUrl? logo,
    @UrlConverter() @RfControl() AbstractUrl? cover,
    @RfArray() List<bool>? tags,
    @SocialUrlConverter() @RfArray<SocialUrl>() List<SocialUrl>? socialLinks,
    @Default(false) bool useCoverAsPreviewPhoto,
  }) = _SciClubFormModel;
  const SciClubFormModel._();

  factory SciClubFormModel.fromJson(Map<String, Object?> json) =>
      _$SciClubFormModelFromJson(json);
}

@freezed
@RfGroup()
class SocialUrl with _$SocialUrl {
  const factory SocialUrl({
    String? id,
    @RfControl(
      validators: [
        RequiredValidator(),
        ComposeOrValidator(
          [
            HttpsValidator(),
            EmailValidator(),
          ],
        ),
      ],
    )
    String? url,
    @RfControl() String? name,
  }) = _SocialUrl;

  factory SocialUrl.fromJson(Map<String, Object?> json) =>
      _$SocialUrlFromJson(() {
        if (!json.containsKey("id") || json["id"] == null) {
          json["id"] = const Uuid().v4();
        }
        return json;
      }());
}

extension IsEmail on SocialUrl {
  bool get isUrlEmail => (url ?? "").isUrlEmail;
}

extension IsEmailString on String {
  bool get isUrlEmail => EmailValidator.emailRegex.hasMatch(this);
}
