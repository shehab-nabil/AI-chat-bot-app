import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/enums/chat_sender.dart';
import '../../domain/usecases/send_message_use_case.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._sendMessage) : super(const ChatState.initial());

  final SendMessageUseCase _sendMessage;
  String? _previousInteractionId;

  Future<void> sendMessage(String message) async {
    if (state is ChatLoading) return;
    final withUserMessage = _append(message, ChatSender.user);
    emit(ChatState.loading(messages: withUserMessage));
    final result = await _sendMessage(
      message: message,
      previousInteractionId: _previousInteractionId,
    );
    result.fold(
      (failure) => emit(
        ChatState.failure(messages: withUserMessage, message: failure.message),
      ),
      (reply) {
        _previousInteractionId = reply.interactionId;
        emit(
          ChatState.success(
            messages: [
              ...withUserMessage,
              ChatMessage(text: reply.text, sender: ChatSender.bot),
            ],
          ),
        );
      },
    );
  }

  List<ChatMessage> _append(String text, ChatSender sender) => [
    ...state.messages,
    ChatMessage(text: text, sender: sender),
  ];
}
