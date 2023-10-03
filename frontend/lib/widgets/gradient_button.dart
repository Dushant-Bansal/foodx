import 'package:flutter/material.dart';
import '../styles/palette.dart';
import '../utilities/default_box_decoration.dart';
import '../utilities/default_padding.dart';
import '../utilities/size.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return DefualtPadding(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: kHeight(context) / 10,
          width: double.maxFinite,
          decoration: defaultBoxDecoration(Palette.lightGreen).copyWith(
            gradient: LinearGradient(
              colors: [Palette.darkGreen, Palette.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
