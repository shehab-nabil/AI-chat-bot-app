import '../../data/models/chat_request_model.dart';
import '../../data/models/chat_response_model.dart';
import '../../data/models/chat_stream_event_model.dart';

/// Sends chat turns to Gemini. Stateless: the caller owns the interaction id
/// (take it from [ChatResponse.id] / [InteractionCreatedEvent.interactionId])
/// and passes it back as [ChatRequest.previousInteractionId].
abstract interface class ChatRepository {
  Future<ChatResponse> send(ChatRequest request);
  Stream<ChatStreamEvent> stream(ChatRequest request);
}
