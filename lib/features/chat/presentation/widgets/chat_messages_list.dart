import 'package:flutter/material.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/enums/chat_sender.dart';
import 'chat_bubble.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({super.key, required this.messages});

  final List<ChatMessage> messages;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(29, 50, 29, 120),
      itemCount: messages.length,
      separatorBuilder: (_, _) => const SizedBox(height: 35),
      itemBuilder: (_, index) {
        final message = messages[index];
        return switch (message.sender) {
          ChatSender.user => UserBubble(text: message.text),
          ChatSender.bot => BotBubble(
            text: message.text,
            showAvatar: true,
            isBody: true,
          ),
        };
      },
    );
  }
}
