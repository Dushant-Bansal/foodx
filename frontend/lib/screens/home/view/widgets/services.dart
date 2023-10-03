import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/screens/bottom_bar/bloc/bottom_bar_cubit.dart';
import 'package:go_router/go_router.dart';
import '../../../../router/constants.dart';
import '../../../../utilities/default_box_decoration.dart';
import '../../../../styles/palette.dart';
import '../../../../styles/text_style.dart';
import '../../../../utilities/default_padding.dart';

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Our Services', style: kPoppinsBold),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: IconCard(
                icon: 'storage',
                iconText: 'Spaces',
                onTap: () => context.read<BottomBarCubit>().update(2),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: IconCard(
                icon: 'inv',
                iconText: 'Inventory',
                onTap: () => context.read<BottomBarCubit>().update(1),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: IconCard(
                icon: 'charity',
                iconText: 'Review',
                onTap: () => context.go('$home/$toBeImplemented'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class IconCard extends StatelessWidget {
  const IconCard({
    super.key,
    required this.icon,
    required this.iconText,
    this.onTap,
  });

  final String icon;
  final String iconText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.lightGrey,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: DefualtPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/icons/$icon.png'),
              Text(
                iconText,
                style: kPoppinsSmallBold,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
