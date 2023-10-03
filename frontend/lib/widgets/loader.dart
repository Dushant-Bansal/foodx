import 'package:flutter/material.dart';
import '../styles/palette.dart';

showLoader(context) {
  return showDialog(
    context: context,
    builder: (context) => Center(
      child: WillPopScope(onWillPop: () async => false, child: const Loader()),
    ),
  );
}

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(color: Palette.green);
  }
}
