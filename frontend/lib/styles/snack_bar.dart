import 'package:flutter/material.dart';
import '../styles/text_style.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey(debugLabel: 'scaffoldMessengerKey');

enum SnackBarType { success, error }

extension SnackBarTypeX on SnackBarType {
  bool get isSuccess => this == SnackBarType.success;

  Color get color =>
      isSuccess ? const Color(0xFF4CAF50) : const Color(0xFFF44336);

  Color get borderColor =>
      isSuccess ? const Color(0xFFBBE2CE) : const Color(0xFFF9D9D7);

  Color get backgroundColor =>
      isSuccess ? const Color(0xFFEDF7F2) : const Color(0xFFFDF3F2);
}

const _defaultSnackBarDuration = Duration(seconds: 2);

void showSuccessSnackBar(
  String message, {
  Duration duration = _defaultSnackBarDuration,
  DismissDirection dismissDirection = DismissDirection.down,
}) {
  _showSnackBar(
    message: message,
    type: SnackBarType.success,
    duration: duration,
    dismissDirection: dismissDirection,
  );
}

void showErrorSnackBar(
  String message, {
  Duration duration = _defaultSnackBarDuration,
  DismissDirection dismissDirection = DismissDirection.down,
}) {
  _showSnackBar(
    message: message,
    type: SnackBarType.error,
    duration: duration,
    dismissDirection: dismissDirection,
  );
}

void _showSnackBar({
  required String message,
  required SnackBarType type,
  Duration duration = _defaultSnackBarDuration,
  DismissDirection dismissDirection = DismissDirection.down,
}) {
  final messenger = scaffoldMessengerKey.currentState;
  // final context = scaffoldMessengerKey.currentContext;

  try {
    messenger?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: kPoppins.copyWith(color: type.color, letterSpacing: -0.4),
        ),
        behavior: SnackBarBehavior.floating,
        duration: duration,
        dismissDirection: dismissDirection,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: type.borderColor),
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: type.backgroundColor,
        clipBehavior: Clip.none,
      ),
    );
  } catch (_) {}
}
