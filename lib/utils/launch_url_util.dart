import 'package:url_launcher/url_launcher.dart';

import '../config/config.dart';
import '../features/form/model/form_model.dart';

class LaunchUrlUtil {
  static Future<bool> launch(String uriStr) async {
    if (uriStr.isUrlEmail) uriStr = FormConfig.mailto + uriStr;
    final uri = Uri.parse(uriStr);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }
}
