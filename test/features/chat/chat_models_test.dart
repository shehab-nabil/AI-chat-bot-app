import 'dart:convert';

import 'package:ai_chat_bot/features/chat/data/models/chat_input_model.dart';
import 'package:ai_chat_bot/features/chat/data/models/chat_request_model.dart';
import 'package:ai_chat_bot/features/chat/data/models/chat_response_model.dart';
import 'package:ai_chat_bot/features/chat/data/models/chat_step_model.dart';
import 'package:ai_chat_bot/features/chat/data/models/chat_stream_event_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChatRequest', () {
    test('first turn omits previous_interaction_id', () {
      const req = ChatRequest(
        model: 'gemini-3.8-flash',
        input: TextInput('I have 2 dogs in my house.'),
        stream: true,
      );
      expect(req.toJson(), {
        'model': 'gemini-3.8-flash',
        'input': 'I have 2 dogs in my house.',
        'stream': true,
      });
      expect(req.toJson().containsKey('previous_interaction_id'), isFalse);
    });

    test('follow-up includes previous_interaction_id', () {
      const req = ChatRequest(
        model: 'gemini-3.8-flash',
        input: TextInput('How many paws are in my house?'),
        previousInteractionId: 'interaction_123',
        stream: true,
      );
      expect(req.toJson(), {
        'model': 'gemini-3.8-flash',
        'input': 'How many paws are in my house?',
        'previous_interaction_id': 'interaction_123',
        'stream': true,
      });
    });

    test('steps input, system_instruction and tools round-trip', () {
      final json = {
        'model': 'm',
        'input': [
          {
            'type': 'user_input',
            'content': [
              {'type': 'text', 'text': 'hi'},
            ],
          },
        ],
        'system_instruction': 'Be brief.',
        'store': true,
        'tools': [
          {'type': 'google_search'},
        ],
      };
      final req = ChatRequest.fromJson(json);
      expect(req.input, isA<StepsInput>());
      expect(req.previousInteractionId, isNull);
      expect(req.toJson(), json);
    });
  });

  group('ChatResponse', () {
    const fixture = '''
{
  "id": "interaction_123",
  "status": "completed",
  "model": "gemini-3.8-flash",
  "created": "2026-05-01T10:00:00Z",
  "updated": "2026-05-01T10:00:02Z",
  "steps": [
    {"type": "thought", "signature": "abc"},
    {"type": "model_output", "content": [{"type": "text", "text": "Nice! "}, {"type": "text", "text": "Dogs are great."}]},
    {"type": "google_search_call", "id": "x"}
  ],
  "usage": {"total_input_tokens": 8, "total_output_tokens": 12, "total_tokens": 20}
}''';

    test('deserializes and exposes outputText', () {
      final r = ChatResponse.fromJson(jsonDecode(fixture));
      expect(r.id, 'interaction_123');
      expect(r.status, ChatStatus.completed);
      expect(r.created, DateTime.utc(2026, 5, 1, 10));
      expect(r.usage!.totalTokens, 20);
      expect(r.steps![0], isA<ThoughtStep>());
      expect(r.steps![2], isA<UnknownStep>());
      expect(r.outputText, 'Nice! Dogs are great.');
    });

    test('only id is required', () {
      final r = ChatResponse.fromJson({'id': 'x'});
      expect(r.status, isNull);
      expect(r.steps, isNull);
      expect(r.usage, isNull);
      expect(r.errors, isNull);
      expect(r.outputText, '');
    });

    test('unknown status maps to unknown; errors parsed', () {
      final r = ChatResponse.fromJson({
        'id': 'x',
        'status': 'brand_new',
        'errors': [
          {'code': 'c', 'message': 'boom'},
        ],
      });
      expect(r.status, ChatStatus.unknown);
      expect(r.errors!.single.message, 'boom');
    });
  });

  group('ChatStreamEvent', () {
    test('step.delta text', () {
      final e = ChatStreamEvent.fromJson({
        'event_type': 'step.delta',
        'index': 1,
        'delta': {'type': 'text', 'text': 'Hello'},
      });
      expect(e, isA<StepDeltaEvent>());
      expect((e as StepDeltaEvent).text, 'Hello');
      expect(e.index, 1);
    });

    test('step.start / step.stop', () {
      final s = ChatStreamEvent.fromJson({
        'event_type': 'step.start',
        'index': 0,
        'step': {'type': 'model_output'},
      });
      expect((s as StepStartEvent).step, isA<ModelOutputStep>());
      expect(
        ChatStreamEvent.fromJson({'event_type': 'step.stop', 'index': 0}),
        isA<StepStopEvent>(),
      );
    });

    test('interaction.created carries the new id', () {
      final e = ChatStreamEvent.fromJson({
        'event_type': 'interaction.created',
        'event_id': 'e1',
        'interaction': {
          'id': 'v1_abc',
          'model': 'gemini-3.8-flash',
          'status': 'in_progress',
          'object': 'interaction',
        },
      }) as InteractionCreatedEvent;
      expect(e.interactionId, 'v1_abc');
      expect(e.eventId, 'e1');
      expect(e.interaction.status, ChatStatus.inProgress);
    });

    test('status_update, completed, error', () {
      final s = ChatStreamEvent.fromJson({
        'event_type': 'interaction.status_update',
        'interaction_id': 'v1',
        'status': 'in_progress',
      }) as InteractionStatusEvent;
      expect(s.status, ChatStatus.inProgress);

      final c = ChatStreamEvent.fromJson({
        'event_type': 'interaction.completed',
        'interaction': {'id': 'v1', 'status': 'completed'},
      }) as InteractionCompletedEvent;
      expect(c.interaction.status, ChatStatus.completed);

      final err = ChatStreamEvent.fromJson({
        'event_type': 'error',
        'error': {'code': 'not_found', 'message': 'gone'},
      }) as StreamErrorEvent;
      expect(err.error.code, 'not_found');
    });

    test('unknown event and unknown delta are preserved', () {
      final e = ChatStreamEvent.fromJson({
        'event_type': 'future.thing',
        'a': 1,
      });
      expect(e, isA<UnknownStreamEvent>());
      expect((e as UnknownStreamEvent).eventType, 'future.thing');

      final d = ChatStreamEvent.fromJson({
        'event_type': 'step.delta',
        'index': 0,
        'delta': {'type': 'google_search_call'},
      }) as StepDeltaEvent;
      expect(d.delta, isA<UnknownDelta>());
      expect(d.text, isNull);
    });
  });
}
