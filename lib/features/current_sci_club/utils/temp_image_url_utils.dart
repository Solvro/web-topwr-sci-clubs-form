import 'dart:html' as html;
import 'dart:typed_data';

class TempImageUrlUtils {
  static (String, html.Blob) getTemporaryUrl(Uint8List data) {
    final blob = html.Blob([data]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    return (url, blob);
  }

  static void revokeUrl(String? url) {
    if (url != null) {
      html.Url.revokeObjectUrl(url);
    }
  }
}
