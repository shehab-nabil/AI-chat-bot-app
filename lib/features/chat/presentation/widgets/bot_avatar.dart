import 'package:flutter/material.dart';

import '../../../../core/themes/colors_manager.dart';

class BotAvatar extends StatelessWidget {
  const BotAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: ColorsManager.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: ColorsManager.avatarShadow, offset: Offset(0, 2)),
          ],
        ),
        child: SizedBox(
          width: 26,
          height: 26,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
            child: Image.asset(
              'assets/images/robot_mascot.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
