import 'package:flutter/material.dart';
import '../../../../styles/palette.dart';
import '../../../../utilities/size.dart';
import 'figures.dart';

class DrawingGreen extends StatelessWidget {
  const DrawingGreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 50,
          top: kHeight(context) / 10 + 20,
          child: CustomPaint(
            painter: Wave2(Palette.whiteGreen),
            size: const Size.square(100),
          ),
        ),
      ],
    );
  }
}

class DrawingSand extends StatelessWidget {
  const DrawingSand({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: kWidth(context) / 10,
          top: kHeight(context) / 7,
          child: Ring(Palette.sand),
        ),
        Positioned(
          left: 0,
          top: kHeight(context) / 2.5,
          child: CustomPaint(
            painter: Wave2(Palette.sand),
            size: const Size.square(100),
          ),
        ),
        Positioned(
          left: 0,
          top: kHeight(context) / 2.5 + 20,
          child: CustomPaint(
            painter: Wave3(Palette.sand),
            size: const Size.square(100),
          ),
        ),
        Positioned(
          left: 0,
          top: kHeight(context) / 2.5 + 50,
          child: CustomPaint(
            painter: Wave2(Palette.sand),
            size: const Size.square(100),
          ),
        ),
      ],
    );
  }
}

class DrawingWhite extends StatelessWidget {
  const DrawingWhite({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: kWidth(context) / 10,
          bottom: kHeight(context) / 15,
          child: Ring(Palette.whiteGreen),
        ),
        Positioned(
          right: 60,
          bottom: -kHeight(context) / 15,
          child: CustomPaint(
            painter: Wave2(Palette.whiteGreen),
            size: const Size.square(100),
          ),
        ),
        Positioned(
          right: 80,
          bottom: -kHeight(context) / 15 + 20,
          child: CustomPaint(
            painter: Wave3(Palette.whiteGreen),
            size: const Size.square(100),
          ),
        ),
        Positioned(
          right: 60,
          bottom: -kHeight(context) / 15 + 50,
          child: CustomPaint(
            painter: Wave2(Palette.whiteGreen),
            size: const Size.square(100),
          ),
        ),
      ],
    );
  }
}
