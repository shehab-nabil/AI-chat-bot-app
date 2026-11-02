import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:ai_chat_bot/core/errors/chat_exceptions.dart';
import 'package:ai_chat_bot/core/services/api_client.dart';
import 'package:ai_chat_bot/features/chat/data/data_sources/gemini_chat_remote_data_source.dart';
import 'package:ai_chat_bot/features/chat/data/data_sources/sse_parser.dart';
import 'package:ai_chat_bot/features/chat/data/models/chat_input_model.dart';
import 'package:ai_chat_bot/features/chat/data/models/chat_request_model.dart';
import 'package:ai_chat_bot/features/chat/data/models/chat_stream_event_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this.handler);

  final Future<ResponseBody> Function(RequestOptions options) handler;
  RequestOptions? last;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    last = options;
    return handler(options);
  }

  @override
  void close({bool force = false}) {}
}

ResponseBody _json(String body, int status) => ResponseBody.fromString(
  body,
  status,
  headers: {
    Headers.contentTypeHeader: ['application/json'],
  },
);

ResponseBody _sse(Stream<List<int>> chunks) => ResponseBody(
  chunks.map(Uint8List.fromList),
  200,
  headers: {
    Headers.contentTypeHeader: ['text/event-stream'],
  },
);

const _req = ChatRequest(
  model: 'gemini-3.8-flash',
  input: TextInput('How many paws are in my house?'),
  previousInteractionId: 'interaction_123',
);

GeminiChatRemoteDataSource _ds(_StubAdapter a) => GeminiChatRemoteDataSource(
  ApiClient(baseUrl: GeminiChatRemoteDataSource.baseUrl, httpClientAdapter: a),
);

String _evt(Map<String, dynamic> j) => 'data: ${jsonEncode(j)}\n\n';

void main() {
  group('parseSse', () {
    test(
      'handles split chunks, multibyte chars, comments, multi-line data',
      () async {
        final bytes = utf8.encode(
          ': ping\nevent: x\ndata: héllo\ndata: world\n\ndata: [DONE]\n\n',
        );
        // Split in the middle of the 2-byte "é".
        final cut = bytes.indexOf(0xC3) + 1;
        final msgs = await parseSse(
          Stream.fromIterable([bytes.sublist(0, cut), bytes.sublist(cut)]),
        ).toList();
        expect(msgs.length, 2);
        expect(msgs[0].event, 'x');
        expect(msgs[0].data, 'héllo\nworld');
        expect(msgs[1].isDone, isTrue);
      },
    );

    test('flushes trailing event without blank line', () async {
      final msgs = await parseSse(Stream.value(utf8.encode('data: {"a":1}')))
          .toList();
      expect(msgs.single.data, '{"a":1}');
    });
  });

  group('createInteraction', () {
    test(
      'posts to /interactions with previous id and parses response',
      () async {
        final a = _StubAdapter(
          (_) async =>
              _json('{"id":"interaction_456","status":"completed"}', 200),
        );
        final r = await _ds(a).createInteraction(_req);
        expect(r.id, 'interaction_456');
        expect(a.last!.uri.path, '/v1beta/interactions');
        expect(a.last!.uri.queryParameters, isEmpty);
        final sent = a.last!.data as Map<String, dynamic>;
        expect(sent['previous_interaction_id'], 'interaction_123');
        expect(sent['stream'], false);
      },
    );

    test('maps API error body', () async {
      final a = _StubAdapter(
        (_) async => _json(
          '{"error":{"code":400,"message":"bad key","status":"INVALID_ARGUMENT"}}',
          400,
        ),
      );
      await expectLater(
        _ds(a).createInteraction(_req),
        throwsA(
          isA<ChatApiException>()
              .having((e) => e.statusCode, 'status', 400)
              .having((e) => e.code, 'code', 'INVALID_ARGUMENT')
              .having((e) => e.message, 'message', 'bad key'),
        ),
      );
    });

    test('malformed JSON -> ChatParseException', () async {
      final a = _StubAdapter((_) async => _json('{not json', 200));
      await expectLater(
        _ds(a).createInteraction(_req),
        throwsA(isA<ChatParseException>()),
      );
    });

    test('connection failure -> ChatNetworkException', () async {
      final a = _StubAdapter(
        (o) async => throw DioException.connectionError(
          requestOptions: o,
          reason: 'offline',
        ),
      );
      await expectLater(
        _ds(a).createInteraction(_req),
        throwsA(isA<ChatNetworkException>()),
      );
    });
  });

  group('streamInteraction', () {
    final created = _evt({
      'event_type': 'interaction.created',
      'interaction': {'id': 'interaction_456', 'status': 'in_progress'},
    });
    final delta = _evt({
      'event_type': 'step.delta',
      'index': 0,
      'delta': {'type': 'text', 'text': 'Hi'},
    });
    final completed = _evt({
      'event_type': 'interaction.completed',
      'interaction': {'id': 'interaction_456', 'status': 'completed'},
    });

    test('uses alt=sse and yields typed events until [DONE]', () async {
      final a = _StubAdapter(
        (_) async => _sse(
          Stream.fromIterable([
            utf8.encode(created),
            utf8.encode('$delta$completed' 'event: done\ndata: [DONE]\n\n'),
          ]),
        ),
      );
      final events = await _ds(a).streamInteraction(_req).toList();
      expect(a.last!.uri.queryParameters['alt'], 'sse');
      expect((a.last!.data as Map)['stream'], true);
      expect(events.map((e) => e.runtimeType), [
        InteractionCreatedEvent,
        StepDeltaEvent,
        InteractionCompletedEvent,
      ]);
      expect(
        (events.first as InteractionCreatedEvent).interactionId,
        'interaction_456',
      );
    });

    test('truncated stream throws ChatStreamException', () async {
      final a = _StubAdapter(
        (_) async => _sse(Stream.value(utf8.encode(created + delta))),
      );
      final seen = <ChatStreamEvent>[];
      await expectLater(
        _ds(a).streamInteraction(_req).forEach(seen.add),
        throwsA(isA<ChatStreamException>()),
      );
      expect(seen.length, 2);
    });

    test('mid-stream failure throws ChatStreamException', () async {
      Stream<List<int>> broken() async* {
        yield utf8.encode(created);
        throw const FormatException('socket reset');
      }

      final a = _StubAdapter((_) async => _sse(broken()));
      await expectLater(
        _ds(a).streamInteraction(_req).toList(),
        throwsA(isA<ChatStreamException>()),
      );
    });

    test('error event is emitted and ends the stream cleanly', () async {
      final a = _StubAdapter(
        (_) async => _sse(
          Stream.value(
            utf8.encode(
              _evt({
                'event_type': 'error',
                'error': {'code': 'gateway_timeout', 'message': 'slow'},
              }),
            ),
          ),
        ),
      );
      final events = await _ds(a).streamInteraction(_req).toList();
      expect((events.single as StreamErrorEvent).error.code, 'gateway_timeout');
    });

    test('malformed event JSON -> ChatParseException', () async {
      final a = _StubAdapter(
        (_) async => _sse(Stream.value(utf8.encode('data: {oops\n\n'))),
      );
      await expectLater(
        _ds(a).streamInteraction(_req).toList(),
        throwsA(isA<ChatParseException>()),
      );
    });

    test('unknown event passes through', () async {
      final a = _StubAdapter(
        (_) async => _sse(
          Stream.value(
            utf8.encode(_evt({'event_type': 'future.thing'}) + completed),
          ),
        ),
      );
      final events = await _ds(a).streamInteraction(_req).toList();
      expect(events.first, isA<UnknownStreamEvent>());
    });

    test('HTTP error on a streaming call is parsed', () async {
      final a = _StubAdapter(
        (_) async => ResponseBody.fromString(
          '{"error":{"code":429,"message":"quota","status":"RESOURCE_EXHAUSTED"}}',
          429,
        ),
      );
      await expectLater(
        _ds(a).streamInteraction(_req).toList(),
        throwsA(
          isA<ChatApiException>().having(
            (e) => e.code,
            'code',
            'RESOURCE_EXHAUSTED',
          ),
        ),
      );
    });
  });
}
