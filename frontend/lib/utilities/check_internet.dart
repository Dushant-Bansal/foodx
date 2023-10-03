import 'dart:io' show InternetAddress, SocketException;

import '../styles/snack_bar.dart';

Future<bool> checkInternet() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } on SocketException catch (_) {
    showSuccessSnackBar('No Internet');
    return false;
  }
  return false;
}
