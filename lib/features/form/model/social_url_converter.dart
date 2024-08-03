import "package:freezed_annotation/freezed_annotation.dart";

import "../../../config/config.dart";
import "form_model.dart";

class SocialUrlConverter extends JsonConverter<List<SocialUrl>, List<dynamic>> {
  const SocialUrlConverter();

  @override
  List<SocialUrl> fromJson(List<dynamic> json) {
    return json.map((json) => SocialUrl.fromJson(_dropMailTo(json))).toList();
  }

  Map<String, dynamic> _dropMailTo(Map<String, dynamic> json) {
    if ((json["url"] as String).startsWith(FormConfig.mailto)) {
      // ignore: avoid_dynamic_calls
      json["url"] = json["url"].replaceAll(FormConfig.mailto, "");
    }
    return json;
  }

  @override
  List<Map<String, dynamic>> toJson(List<SocialUrl> object) {
    return object.map((object) {
      if (object.isUrlEmail) {
        return SocialUrl(
          url: "${FormConfig.mailto}${object.url}",
          name: object.url,
        ).toJson();
      }
      if (object.name == null || object.name!.trim().isEmpty) {
        return object
            .copyWith(
              name: object.url
                  ?.replaceAll("https://", "")
                  .replaceAll("http://", ""),
            )
            .toJson();
      }
      return object.toJson();
      // return [url.url, url.name];
    }).toList();
  }
}
