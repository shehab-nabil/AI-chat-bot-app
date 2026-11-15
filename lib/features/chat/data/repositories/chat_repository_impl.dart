import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/errors/chat_exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/chat_reply.dart';
import '../../domain/repositories/chat_repository.dart';
import '../data_sources/gemini_chat_remote_data_source.dart';
import '../models/chat_input_model.dart';
import '../models/chat_request_model.dart';
import '../models/chat_response_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl(this._remote, {required this.model});

  final GeminiChatRemoteDataSource _remote;
  final String model;

  @override
  Future<Either<Failure, ChatReply>> sendMessage({
    required String message,
    String? previousInteractionId,
  }) async {
    final request = ChatRequest(
      model: model,
      input: TextInput(message),
      previousInteractionId: previousInteractionId,
    );
    try {
      final response = await _remote.createInteraction(request);
      return Right(_toReply(response));
    } on ChatException catch (e) {
      return Left(_toFailure(e));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Request cancelled'));
    }
  }

  ChatReply _toReply(ChatResponse response) =>
      ChatReply(interactionId: response.id, text: response.outputText);

  Failure _toFailure(ChatException e) => switch (e) {
    ChatApiException() => ServerFailure(e.message, statusCode: e.statusCode),
    ChatNetworkException() => NetworkFailure(e.message),
    ChatParseException() => ParseFailure(e.message),
    ChatStreamException() => StreamFailure(e.message),
  };
}
