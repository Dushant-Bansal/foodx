import 'package:flutter/material.dart';
import '../../../../styles/palette.dart';
import '../../../../styles/text_style.dart';

class HomeCardText extends StatelessWidget {
  const HomeCardText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stay Fresh\nWaste Less',
            style: kPoppinsBoldWhiteSmall,
          ),
          const SizedBox(height: 10),
          Text(
            'Your Food Management Hub',
            style: kPoppinsLightWhiteSmall,
          ),
        ],
      ),
    );
  }
}

class SubHomeCardText extends StatelessWidget {
  const SubHomeCardText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instantly Add Items',
          style: kPoppinsBold.copyWith(color: Palette.green),
        ),
        const SizedBox(height: 5),
        Text(
          'Quickly Add Products to Your Inventory',
          style: kPoppinsSmall,
        ),
      ],
    );
  }
}
