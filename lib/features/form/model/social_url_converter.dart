import 'package:freezed_annotation/freezed_annotation.dart';

import 'form_model.dart';

class SocialUrlConverter
    extends JsonConverter<List<SocialUrl>, List<Map<String, dynamic>>> {
  const SocialUrlConverter();

  @override
  List<SocialUrl> fromJson(List<Map<String, dynamic>> json) {
    return json.map((json) => SocialUrl.fromJson(json)).toList();
  }

  @override
  List<Map<String, dynamic>> toJson(List<SocialUrl> object) {
    return object.map((object) {
      if (object.isUrlEmail) {
        return SocialUrl(
          url: "mailto:${object.url}",
          name: object.url,
        ).toJson();
      }
      if (object.name == null || object.name!.trim().isEmpty) {
        return object
            .copyWith(
                name: object.url
                    ?.replaceAll("https://", "")
                    .replaceAll("http://", ""))
            .toJson();
      }
      return object.toJson();
      // return [url.url, url.name];
    }).toList();
  }
}
