import 'package:flutter/material.dart';

import 'chat_bubble.dart';

const _longReply =
    'There are many programming languages in the market that are used in '
    'designing and building websites, various applications and other tasks. '
    'All these languages are popular in their place and in the way they are '
    'used, and many programmers learn and use them.';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(29, 50, 29, 120),
      children: const [
        BotBubble(text: 'Hello,i’m fine,how can i help you?', showAvatar: true),
        SizedBox(height: 35),
        UserBubble(text: 'What is the best programming language?'),
        SizedBox(height: 36),
        BotBubble(text: _longReply, showAvatar: true, isBody: true),
        SizedBox(height: 41),
        UserBubble(text: 'So explain to me more'),
        SizedBox(height: 29),
        Opacity(opacity: 0.5, child: BotBubble(text: _longReply, isBody: true)),
      ],
    );
  }
}
