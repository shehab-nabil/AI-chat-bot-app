import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/chat_reply.dart';
import '../repositories/chat_repository.dart';

class SendMessageUseCase {
  const SendMessageUseCase(this._repository);

  final ChatRepository _repository;

  Future<Either<Failure, ChatReply>> call({
    required String message,
    String? previousInteractionId,
  }) => _repository.sendMessage(
    message: message,
    previousInteractionId: previousInteractionId,
  );
}
