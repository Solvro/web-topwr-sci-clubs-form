import 'package:freezed_annotation/freezed_annotation.dart';

class HexConverter implements JsonConverter<String, String> {
  const HexConverter();

  @override
  String fromJson(String json) {
    return String.fromCharCodes(_hexDecode(json));
  }

  @override
  String toJson(String object) {
    return _hexEncode(object.codeUnits);
  }

  List<int> _hexDecode(String hex) {
    return List.generate(hex.length ~/ 2, (i) {
      final byte = hex.substring(i * 2, i * 2 + 2);
      return int.parse(byte, radix: 16);
    });
  }

  String _hexEncode(List<int> bytes) {
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }
}
