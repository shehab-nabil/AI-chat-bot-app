import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/themes/colors_manager.dart';
import '../../../../core/themes/text_styles.dart';

class ChatInputBar extends StatelessWidget {
  const ChatInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: ColorsManager.shadow,
            offset: Offset(5, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Text('Write your message', style: TextStyles.inputHint),
          ),
          SvgPicture.asset(
            'assets/icons/microphone.svg',
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 7),
          SvgPicture.asset('assets/icons/send.svg', width: 24, height: 24),
        ],
      ),
    );
  }
}
