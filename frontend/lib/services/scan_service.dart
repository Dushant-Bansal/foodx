import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../styles/palette.dart';

class ScanService {
  ScanService._();

  static Future<String> scanBarcode() async {
    try {
      String code = await FlutterBarcodeScanner.scanBarcode(
        Palette.darkGreen.toHex(leadingHashSign: true),
        'Cancel',
        false,
        ScanMode.BARCODE,
      );
      if (int.parse(code) == -1) {
        throw const ScanException('Failed to scan barcode. Please try again.');
      }
      return code;
    } catch (e) {
      if (e is ScanException) {
        rethrow;
      } else {
        throw ScanException(e.toString());
      }
    }
  }
}

class ScanException implements Exception {
  const ScanException(this.error);

  final String error;
}
