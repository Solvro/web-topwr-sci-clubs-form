import 'package:freezed_annotation/freezed_annotation.dart';

import '../../form/model/enums.dart';
import '../../form/model/form_model.dart';

part 'sci_club.freezed.dart';
part 'sci_club.g.dart';

@freezed
class SciClub with _$SciClub {
  const factory SciClub({
    required String name,
    required String? department,
    required List<String> tags,
    String? logo,
    String? cover,
    required List<SocialUrl> socialLinks,
    required SciClubType type,
    @Default(Source.manualEntry) Source source,
    String? description,
    String? shortDescription,
  }) = _SciClub;

  factory SciClub.fromJson(Map<String, Object?> json) =>
      _$SciClubFromJson(json);
}
