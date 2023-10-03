import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_x/screens/bottom_bar/bloc/bottom_bar_cubit.dart';
import '../../styles/palette.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(25.0),
        decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(40.0),
          boxShadow: [
            BoxShadow(
              color: Palette.iconColor,
              offset: const Offset(0.0, 3.0),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: const Row(
          children: [
            BarIcon(iconData: Icons.home_outlined, index: 0),
            BarIcon(iconData: Icons.inventory_2_outlined, index: 1),
            BarIcon(iconData: Icons.workspaces_outline, index: 2),
            BarIcon(iconData: Icons.shopping_bag_outlined, index: 3),
          ],
        ),
      ),
    );
  }
}

class BarIcon extends StatelessWidget {
  const BarIcon({
    Key? key,
    required this.iconData,
    required this.index,
  }) : super(key: key);

  final IconData iconData;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomBarCubit, int>(
      builder: (context, state) {
        return Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => context.read<BottomBarCubit>().update(index),
                child: Icon(iconData, color: Palette.iconColor, size: 32.0),
              ),
              const SizedBox(height: 10),
              state == index
                  ? CircleAvatar(
                      backgroundColor: Palette.lightGreen, radius: 4.0)
                  : Container(),
            ],
          ),
        );
      },
    );
  }
}
