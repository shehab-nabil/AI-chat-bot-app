import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/send_message_use_case.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._sendMessage) : super(const ChatState.initial());

  final SendMessageUseCase _sendMessage;
  String? _previousInteractionId;

  Future<void> sendMessage(String message) async {
    if (state is ChatLoading) return;
    emit(const ChatState.loading());
    final result = await _sendMessage(
      message: message,
      previousInteractionId: _previousInteractionId,
    );
    result.fold((failure) => emit(ChatState.failure(failure.message)), (reply) {
      _previousInteractionId = reply.interactionId;
      emit(ChatState.success(reply));
    });
  }
}
