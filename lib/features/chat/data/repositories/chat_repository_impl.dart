import '../../domain/repositories/chat_repository.dart';
import '../data_sources/gemini_chat_remote_data_source.dart';
import '../models/chat_request_model.dart';
import '../models/chat_response_model.dart';
import '../models/chat_stream_event_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  const ChatRepositoryImpl(this._remote);

  final GeminiChatRemoteDataSource _remote;

  @override
  Future<ChatResponse> send(ChatRequest request) =>
      _remote.createInteraction(request);

  @override
  Stream<ChatStreamEvent> stream(ChatRequest request) =>
      _remote.streamInteraction(request);
}
