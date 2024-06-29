import 'dart:typed_data';

import '../utils/temp_image_url_utils.dart';

sealed class AbstractUrl {
  abstract final String url;
}

class NormalUrl extends AbstractUrl {
  NormalUrl(this.url);

  @override
  final String url;
}

class TempUrl extends AbstractUrl {
  static final Finalizer<String> _finalizer =
      Finalizer(TempImageUrlUtils.revokeUrl);
  static final Map<Uint8List, TempUrl> _cache = {};

  @override
  final String url;

  TempUrl._(this.url);

  factory TempUrl.fromUint8List(Uint8List bytes) {
    if (_cache.containsKey(bytes)) {
      return _cache[bytes]!;
    }

    final url = TempImageUrlUtils.getTemporaryUrl(bytes);
    final wrapper = TempUrl._(url);
    _finalizer.attach(wrapper, url, detach: wrapper);
    _cache[bytes] = wrapper;
    return wrapper;
  }

  void manualRelease() {
    TempImageUrlUtils.revokeUrl(url);
    _finalizer.detach(this);
  }
}