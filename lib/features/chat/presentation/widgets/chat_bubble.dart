import 'package:flutter/material.dart';

import '../../../../core/themes/colors_manager.dart';
import '../../../../core/themes/text_styles.dart';
import 'bot_avatar.dart';

const _bubbleRadius = Radius.circular(25);

class UserBubble extends StatelessWidget {
  const UserBubble({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(left: 55),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: ColorsManager.primary,
            borderRadius: BorderRadius.only(
              topLeft: _bubbleRadius,
              bottomLeft: _bubbleRadius,
              bottomRight: _bubbleRadius,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
            child: Text(text, style: TextStyles.userMessage),
          ),
        ),
      ),
    );
  }
}

class BotBubble extends StatelessWidget {
  const BotBubble({
    super.key,
    required this.text,
    this.showAvatar = false,
    this.isBody = false,
  });

  final String text;
  final bool showAvatar;
  final bool isBody;

  @override
  Widget build(BuildContext context) {
    final style = isBody ? TextStyles.botMessageBody : TextStyles.botMessage;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(width: 33, child: showAvatar ? const BotAvatar() : null),
        Flexible(
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: ColorsManager.botBubble,
              borderRadius: BorderRadius.only(
                topLeft: _bubbleRadius,
                topRight: _bubbleRadius,
                bottomRight: _bubbleRadius,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isBody ? 13 : 36,
                vertical: isBody ? 22 : 18,
              ),
              child: Text(text, style: style),
            ),
          ),
        ),
        const SizedBox(width: 61),
      ],
    );
  }
}
