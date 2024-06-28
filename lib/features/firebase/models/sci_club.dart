import 'package:freezed_annotation/freezed_annotation.dart';

import '../../current_sci_club/models/converter.dart';
import '../../current_sci_club/models/url.dart';
import '../../form/model/enums.dart';
import '../../form/model/form_model.dart';

part 'sci_club.freezed.dart';
part 'sci_club.g.dart';

@freezed
class SciClub with _$SciClub {
  const factory SciClub({
    String? id,
    String? name,
    String? department,
    @Default([]) List<String> tags,
    @UrlConverter() AbstractUrl? logo,
    @UrlConverter() AbstractUrl? cover,
    @Default([]) List<SocialUrl> socialLinks,
    SciClubType? type,
    @Default(Source.manualEntry) Source? source,
    String? description,
    String? shortDescription,
  }) = _SciClub;

  factory SciClub.fromJson(Map<String, Object?> json) =>
      _$SciClubFromJson(json);
}
