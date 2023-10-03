import 'package:flutter/material.dart';
import 'package:food_x/utilities/size.dart';
import 'widgets/drawing.dart';
import '../../../styles/palette.dart';
import '../../../styles/text_style.dart';
import 'widgets/sign_in.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.darkGreen,
      body: Stack(
        children: [
          const Drawing(),
          Positioned(
              top: kHeight(context) / 16, child: const InitialPageText()),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: kHeight(context) / 3.2),
              const SignIn(),
            ],
          ),
        ],
      ),
    );
  }
}

class Drawing extends StatelessWidget {
  const Drawing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        DrawingSand(),
        DrawingWhite(),
        DrawingGreen(),
      ],
    );
  }
}

class InitialPageText extends StatelessWidget {
  const InitialPageText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello Again\nWelcome Back',
            style: kPoppinsBoldWhite,
          ),
          const SizedBox(height: 20.0),
          Text.rich(
            TextSpan(
              text: 'Turning ',
              children: <InlineSpan>[
                TextSpan(
                  text: ' almost expired',
                  style: kPoppinsBoldWhiteSmall,
                ),
                const TextSpan(text: '\ninto '),
                TextSpan(
                  text: ' perfectly enjoyed.',
                  style: kPoppinsBoldWhiteSmall,
                ),
              ],
            ),
            style: kPoppinsLightWhite,
          ),
        ],
      ),
    );
  }
}
