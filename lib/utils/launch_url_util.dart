import "package:url_launcher/url_launcher.dart";

import "../config/config.dart";
import "../features/form/model/form_model.dart";

class LaunchUrlUtil {
  static Future<bool> launch(String uriStr) async {
    String modifiedUriStr = uriStr;
    if (modifiedUriStr.isUrlEmail) {
      modifiedUriStr = FormConfig.mailto + modifiedUriStr;
    }
    final uri = Uri.parse(modifiedUriStr);
    if (await canLaunchUrl(uri)) {
      return launchUrl(uri);
    }
    return false;
  }
}
