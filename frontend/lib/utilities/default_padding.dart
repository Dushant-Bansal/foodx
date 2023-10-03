import 'package:flutter/material.dart';

class DefualtPadding extends StatelessWidget {
  const DefualtPadding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(20.0), child: child);
  }
}
