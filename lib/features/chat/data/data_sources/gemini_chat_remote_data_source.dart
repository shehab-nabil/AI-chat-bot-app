import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/errors/chat_exceptions.dart';
import '../../../../core/services/api_client.dart';
import '../models/chat_error_model.dart';
import '../models/chat_request_model.dart';
import '../models/chat_response_model.dart';
import '../models/chat_stream_event_model.dart';
import 'sse_parser.dart';

/// Talks to `POST https://generativelanguage.googleapis.com/v1beta/interactions`.
///
/// The [ApiClient] must be built with [baseUrl] and the `x-goog-api-key`
/// header (supplied from configuration, never hardcoded).
class GeminiChatRemoteDataSource {
  GeminiChatRemoteDataSource(this._client);

  static const baseUrl = 'https://generativelanguage.googleapis.com/v1beta';
  static const _path = '/interactions';

  final ApiClient _client;

  /// Non-streaming call. [request.stream] is forced off.
  Future<ChatResponse> createInteraction(
    ChatRequest request, {
    CancelToken? cancelToken,
  }) async {
    final Response<String> response;
    try {
      response = await _client.post<String>(
        _path,
        data: request.copyWith(stream: false).toJson(),
        options: Options(responseType: ResponseType.plain),
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw await _mapDioException(e);
    }
    final json = _decodeObject(response.data);
    try {
      return ChatResponse.fromJson(json);
    } catch (e) {
      throw ChatParseException('Unexpected interaction shape', cause: e);
    }
  }

  /// Streaming call (`?alt=sse`). [request.stream] is forced on.
  ///
  /// Emits typed events in server order. Server `error` events are emitted as
  /// [StreamErrorEvent] and end the stream. Throws [ChatStreamException] if the
  /// connection drops, or the stream ends without `interaction.completed`,
  /// `error` or `[DONE]`; [ChatParseException] on malformed event JSON.
  Stream<ChatStreamEvent> streamInteraction(
    ChatRequest request, {
    CancelToken? cancelToken,
  }) async* {
    final Response<ResponseBody> response;
    try {
      response = await _client.post<ResponseBody>(
        _path,
        data: request.copyWith(stream: true).toJson(),
        queryParameters: {'alt': 'sse'},
        options: Options(
          responseType: ResponseType.stream,
          headers: {'Accept': 'text/event-stream'},
        ),
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw await _mapDioException(e);
    }

    var finished = false;
    try {
      await for (final message in parseSse(response.data!.stream)) {
        if (message.isDone) {
          finished = true;
          break;
        }
        final event = ChatStreamEvent.fromJson(_decodeObject(message.data));
        if (event is InteractionCompletedEvent || event is StreamErrorEvent) {
          finished = true;
        }
        yield event;
        if (event is StreamErrorEvent) return;
      }
    } on ChatException {
      rethrow;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) rethrow;
      throw ChatStreamException('Stream interrupted: ${e.message}', cause: e);
    } catch (e) {
      throw ChatStreamException('Stream interrupted: $e', cause: e);
    }
    if (!finished) {
      throw const ChatStreamException(
        'Stream ended before the interaction completed',
      );
    }
  }

  Map<String, dynamic> _decodeObject(Object? raw) {
    try {
      final decoded = raw is String ? jsonDecode(raw) : raw;
      if (decoded is Map<String, dynamic>) return decoded;
      throw const FormatException('Expected a JSON object');
    } on FormatException catch (e) {
      throw ChatParseException('Malformed JSON: ${e.message}', cause: e);
    }
  }

  Future<ChatException> _mapDioException(DioException e) async {
    switch (e.type) {
      case DioExceptionType.badResponse:
        final status = e.response?.statusCode;
        final body = await _readErrorBody(e.response?.data);
        final error = ChatError.fromHttpBody(body);
        return ChatApiException(
          error?.message ?? 'HTTP $status',
          statusCode: status,
          code: error?.code,
          cause: e,
        );
      case DioExceptionType.cancel:
        throw e; // Cancellation is caller-initiated; do not rewrap.
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return ChatNetworkException(e.message ?? 'Network error', cause: e);
    }
  }

  Future<Object?> _readErrorBody(Object? data) async {
    try {
      if (data is ResponseBody) {
        final bytes = await data.stream.expand((c) => c).toList();
        return jsonDecode(utf8.decode(bytes));
      }
      return data is String ? jsonDecode(data) : data;
    } catch (_) {
      return null; // Non-JSON error body: fall back to the HTTP status.
    }
  }
}
