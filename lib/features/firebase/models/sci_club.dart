import "package:freezed_annotation/freezed_annotation.dart";

import "../../current_sci_club/models/converter.dart";
import "../../current_sci_club/models/url.dart";
import "../../form/model/enums.dart";
import "../../form/model/form_model.dart";
import "../../form/model/social_url_converter.dart";

part "sci_club.freezed.dart";
part "sci_club.g.dart";

@freezed
class SciClub with _$SciClub {
  const factory SciClub({
    String? id,
    String? userId,
    String? name,
    String? department,
    @Default([]) List<String> tags,
    @UrlConverter() AbstractUrl? logo,
    @UrlConverter() AbstractUrl? cover,
    @SocialUrlConverter() @Default([]) List<SocialUrl> socialLinks,
    SciClubType? type,
    @Default(Source.manualEntry) Source? source,
    String? description,
    String? shortDescription,
    @Default(false) bool useCoverAsPreviewPhoto,
  }) = _SciClub;

  const SciClub._();

  factory SciClub.fromJson(Map<String, Object?> json) =>
      _$SciClubFromJson(json);

  AbstractUrl? get previewUrl =>
      useCoverAsPreviewPhoto ? cover ?? logo : logo ?? cover;
}
