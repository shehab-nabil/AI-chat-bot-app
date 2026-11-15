import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/chat_reply.dart';

part 'chat_state.freezed.dart';

@freezed
sealed class ChatState with _$ChatState {
  const factory ChatState.initial() = ChatInitial;
  const factory ChatState.loading() = ChatLoading;
  const factory ChatState.success(ChatReply reply) = ChatSuccess;
  const factory ChatState.failure(String message) = ChatFailure;
}
