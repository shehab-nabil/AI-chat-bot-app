import 'package:flutter/material.dart';

import '../../../../core/themes/colors_manager.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_messages_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: Column(
          children: [
            ChatAppBar(),
            Expanded(
              child: Stack(
                children: [
                  ChatMessagesList(),
                  Positioned(
                    left: 18,
                    right: 24,
                    bottom: 24,
                    child: ChatInputBar(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
