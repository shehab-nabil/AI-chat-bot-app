import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/themes/colors_manager.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_messages_list.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: SafeArea(
        child: Column(
          children: [
            const ChatAppBar(),
            Expanded(
              child: Stack(
                children: [
                  BlocBuilder<ChatCubit, ChatState>(
                    buildWhen: (_, current) =>
                        current is ChatInitial ||
                        current is ChatLoading ||
                        current is ChatSuccess ||
                        current is ChatFailure,
                    builder: (_, state) =>
                        ChatMessagesList(messages: state.messages),
                  ),
                  const Positioned(
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
