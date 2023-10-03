import 'package:flutter/material.dart';

class Palette {
  Palette._();

  static Color get black => const Color(0xFF535068);
  static Color get blue => const Color(0xFF4E71FF);
  static Color get darkGreen => const Color(0xFF5EA660);
  static Color get green => const Color(0xFF64CC84);
  static Color get iconColor => const Color(0xFFB5B7D1);
  static Color get lightGreen => const Color(0xFF68D588);
  static Color get lightGrey => const Color(0xFFF7F8FC);
  static Color get grey => const Color(0xFF808080);
  static Color get sand => const Color(0xFFC5D867);
  static Color get transparent => const Color(0x00000000);
  static Color get white => const Color(0xFFFFFFFF);
  static Color get whiteGreen => const Color(0xFF6CB963);
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
