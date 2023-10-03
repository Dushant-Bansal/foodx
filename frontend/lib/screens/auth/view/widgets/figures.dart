import 'package:flutter/material.dart';

import '../../../../styles/palette.dart';

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

class Ring extends StatelessWidget {
  const Ring(Color color, {super.key}) : _color = color;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: _color,
      radius: 20.0,
      child: CircleAvatar(
        backgroundColor: Palette.darkGreen,
        radius: 10.0,
      ),
    );
  }
}

class Wave2 extends CustomPainter {
  Wave2(Color color) : _color = color;
  final Color _color;
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.quadraticBezierTo(40, 10, 80, 0);
    path.quadraticBezierTo(120, -15, 160, 5);
    canvas.drawPath(
      path,
      Paint()
        ..color = _color
        ..strokeWidth = 5.0
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(Wave2 oldDelegate) => false;
}

class Wave3 extends CustomPainter {
  Wave3(Color color) : _color = color;
  final Color _color;
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.quadraticBezierTo(25, 10, 80, 0);
    path.quadraticBezierTo(110, -10, 140, 0);
    path.quadraticBezierTo(160, 10, 180, 0);
    canvas.drawPath(
      path,
      Paint()
        ..color = _color
        ..strokeWidth = 5.0
        ..style = PaintingStyle.stroke
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(Wave3 oldDelegate) => false;
}
