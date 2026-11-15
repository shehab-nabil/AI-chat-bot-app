import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/themes/colors_manager.dart';
import '../../../../core/themes/text_styles.dart';
import '../cubit/chat_cubit.dart';

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({super.key});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    context.read<ChatCubit>().sendMessage(text);
    _controller.clear();
  }

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
          Expanded(
            child: TextField(
              controller: _controller,
              style: TextStyles.inputText,
              cursorColor: ColorsManager.primary,
              decoration: const InputDecoration(
                hintText: 'Write your message',
                hintStyle: TextStyles.inputHint,
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
          SvgPicture.asset(
            'assets/icons/microphone.svg',
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 7),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _send,
            child: SvgPicture.asset(
              'assets/icons/send.svg',
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
