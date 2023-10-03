import 'package:flutter/material.dart';
import 'package:food_x/router/constants.dart';
import 'package:food_x/router/router.dart';
import 'package:food_x/screens/spaces/models/invited_users.dart';
import 'package:food_x/screens/spaces/models/space.dart';
import 'package:food_x/services/auth_service.dart';
import 'package:food_x/styles/palette.dart';
import 'package:food_x/styles/text_style.dart';
import 'package:food_x/utilities/default_box_decoration.dart';
import 'package:food_x/utilities/extensions.dart';
import 'package:go_router/go_router.dart';

class SpaceTile extends StatelessWidget {
  const SpaceTile({
    super.key,
    required this.space,
    this.onTap,
  });

  final Space space;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Palette.lightGrey,
      borderRadius: borderRadius,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Palette.lightGreen,
                  radius: 24,
                  child: Text(
                    space.name.characters.first.toUpperCase(),
                    style: kPoppinsLightWhiteLarge,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  space.name.capitalize(),
                  style: kPoppins,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            space.spaceUsers
                        .firstWhere((element) => element.role.isAdmin)
                        .uid
                        .email ==
                    AuthService.email
                ? Positioned(
                    top: 2,
                    right: 2,
                    child: IconButton(
                      onPressed: () => context
                          .go('${context.path}/$spaceSettings', extra: space),
                      icon: const Icon(Icons.settings),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
