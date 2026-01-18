import 'dart:convert';
import 'package:crypto/crypto.dart';

class HashUtils {
  static String sha256FromString(String input) {
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString();
  }

  static String sha256FromBytes(List<int> bytes) {
    return sha256.convert(bytes).toString();
  }
}
