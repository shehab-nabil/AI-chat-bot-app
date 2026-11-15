import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/chat_reply.dart';

abstract interface class ChatRepository {
  Future<Either<Failure, ChatReply>> sendMessage({
    required String message,
    String? previousInteractionId,
  });
}
