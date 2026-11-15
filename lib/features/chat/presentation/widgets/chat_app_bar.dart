import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/themes/colors_manager.dart';
import '../../../../core/themes/text_styles.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 29),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: ColorsManager.divider)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/arrow_left.svg',
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 17),
          Image.asset('assets/images/robot_mascot.png', width: 24, height: 36),
          const SizedBox(width: 20),
          const Expanded(child: _TitleAndStatus()),
          SvgPicture.asset(
            'assets/icons/volume_high.svg',
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 19),
          SvgPicture.asset('assets/icons/export.svg', width: 24, height: 24),
        ],
      ),
    );
  }
}

// ─── Private widgets ─────────────────────────────────────────────

class _TitleAndStatus extends StatelessWidget {
  const _TitleAndStatus();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ChatGPT', style: TextStyles.headerTitle),
        SizedBox(height: 1),
        Row(
          children: [
            _OnlineDot(),
            SizedBox(width: 5),
            Text('Online', style: TextStyles.headerStatus),
          ],
        ),
      ],
    );
  }
}

class _OnlineDot extends StatelessWidget {
  const _OnlineDot();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: ColorsManager.online,
        shape: BoxShape.circle,
      ),
      child: SizedBox(width: 6, height: 6),
    );
  }
}
