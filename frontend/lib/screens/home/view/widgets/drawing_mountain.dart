import 'package:flutter/material.dart';
import '../../../../styles/palette.dart';
import '../../../../utilities/size.dart';

class Mountain extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height / 4);
    path.quadraticBezierTo(
        size.width / 8, -size.height / 4, size.width / 4, size.height / 2);
    path.moveTo(size.width / 4, size.height / 2);
    path.quadraticBezierTo(
        3 / 8 * size.width, 0, size.width / 2, 3 / 4 * size.height);
    path.lineTo(size.width / 4, 3 / 4 * size.height);
    path.lineTo(0, size.height / 1.6);
    path.lineTo(0, size.height / 4);
    path.moveTo(size.width / 3, 3 / 4 * size.height);
    path.quadraticBezierTo(
        size.width / 2, 1 / 4 * size.height, size.width, 3 / 4 * size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}

class DrawingMountain extends StatelessWidget {
  const DrawingMountain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: ClipPath(
        clipper: Mountain(),
        child: Container(
          height: kHeight(context),
          width: kWidth(context),
          color: Palette.green,
        ),
      ),
    );
  }
}
