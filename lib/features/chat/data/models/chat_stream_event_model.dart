import 'chat_error_model.dart';
import 'chat_response_model.dart';
import 'chat_step_model.dart';

/// Incremental payload of a `step.delta` event, discriminated by `delta.type`.
sealed class StepDelta {
  const StepDelta();

  factory StepDelta.fromJson(Map<String, dynamic> json) {
    return switch (json['type']) {
      'text' => TextDelta(json['text'] as String? ?? ''),
      'thought_summary' => ThoughtSummaryDelta(json),
      'thought_signature' => ThoughtSignatureDelta(
        json['signature'] as String?,
        json,
      ),
      'arguments_delta' => ArgumentsDelta(json),
      _ => UnknownDelta(json),
    };
  }
}

/// A partial chunk of model text.
class TextDelta extends StepDelta {
  const TextDelta(this.text);

  final String text;
}

/// Thought summary chunk. The field layout is not fully documented, so the
/// raw delta is kept in [raw].
class ThoughtSummaryDelta extends StepDelta {
  const ThoughtSummaryDelta(this.raw);

  final Map<String, dynamic> raw;
}

class ThoughtSignatureDelta extends StepDelta {
  const ThoughtSignatureDelta(this.signature, this.raw);

  final String? signature;
  final Map<String, dynamic> raw;
}

/// Partial JSON of function-call arguments; concatenate across deltas.
class ArgumentsDelta extends StepDelta {
  const ArgumentsDelta(this.raw);

  final Map<String, dynamic> raw;
}

/// Any other documented delta (image, google_search_call, ...), kept raw.
class UnknownDelta extends StepDelta {
  const UnknownDelta(this.raw);

  final Map<String, dynamic> raw;

  String? get type => raw['type'] as String?;
}

/// A typed SSE event of the Interactions API, discriminated by `event_type`.
sealed class ChatStreamEvent {
  const ChatStreamEvent({this.eventId});

  /// Opaque id usable to resume a stream, when the server sends one.
  final String? eventId;

  /// Parses the JSON `data:` payload of one SSE message.
  /// Unrecognised `event_type`s become [UnknownStreamEvent].
  factory ChatStreamEvent.fromJson(Map<String, dynamic> json) {
    final eventId = json['event_id'] as String?;
    Map<String, dynamic>? map(String key) =>
        (json[key] as Map?)?.cast<String, dynamic>();

    switch (json['event_type']) {
      case 'interaction.created':
        final i = map('interaction');
        if (i == null) return UnknownStreamEvent(json);
        return InteractionCreatedEvent(
          ChatResponse.fromJson(i),
          eventId: eventId,
        );
      case 'interaction.status_update':
        return InteractionStatusEvent(
          interactionId: json['interaction_id'] as String?,
          status: _parseStatus(json['status'] as String?),
          eventId: eventId,
        );
      case 'step.start':
        final step = map('step');
        if (step == null) return UnknownStreamEvent(json);
        return StepStartEvent(
          index: json['index'] as int? ?? 0,
          step: ChatStep.fromJson(step),
          eventId: eventId,
        );
      case 'step.delta':
        final delta = map('delta');
        if (delta == null) return UnknownStreamEvent(json);
        return StepDeltaEvent(
          index: json['index'] as int? ?? 0,
          delta: StepDelta.fromJson(delta),
          eventId: eventId,
        );
      case 'step.stop':
        return StepStopEvent(
          index: json['index'] as int? ?? 0,
          eventId: eventId,
        );
      case 'interaction.completed':
        final i = map('interaction');
        if (i == null) return UnknownStreamEvent(json);
        return InteractionCompletedEvent(
          ChatResponse.fromJson(i),
          eventId: eventId,
        );
      case 'error':
        final e = map('error');
        return StreamErrorEvent(
          e == null ? const ChatError() : ChatError.fromJson(e),
          eventId: eventId,
        );
      default:
        return UnknownStreamEvent(json);
    }
  }
}

ChatStatus? _parseStatus(String? value) {
  if (value == null) return null;
  for (final s in ChatStatus.values) {
    if (_snake(s.name) == value) return s;
  }
  return ChatStatus.unknown;
}

String _snake(String s) =>
    s.replaceAllMapped(RegExp('[A-Z]'), (m) => '_${m[0]!.toLowerCase()}');

/// First event; carries the (partial) interaction, including its new `id`.
class InteractionCreatedEvent extends ChatStreamEvent {
  const InteractionCreatedEvent(this.interaction, {super.eventId});

  final ChatResponse interaction;
  String get interactionId => interaction.id;
}

class InteractionStatusEvent extends ChatStreamEvent {
  const InteractionStatusEvent({
    this.interactionId,
    this.status,
    super.eventId,
  });

  final String? interactionId;
  final ChatStatus? status;
}

class StepStartEvent extends ChatStreamEvent {
  const StepStartEvent({
    required this.index,
    required this.step,
    super.eventId,
  });

  final int index;
  final ChatStep step;
}

class StepDeltaEvent extends ChatStreamEvent {
  const StepDeltaEvent({
    required this.index,
    required this.delta,
    super.eventId,
  });

  final int index;
  final StepDelta delta;

  /// Partial text if this is a text delta, otherwise null.
  String? get text => switch (delta) {
    TextDelta(:final text) => text,
    _ => null,
  };
}

class StepStopEvent extends ChatStreamEvent {
  const StepStopEvent({required this.index, super.eventId});

  final int index;
}

/// Final event with the completed interaction (status, steps, usage).
class InteractionCompletedEvent extends ChatStreamEvent {
  const InteractionCompletedEvent(this.interaction, {super.eventId});

  final ChatResponse interaction;
}

/// An `error` event sent by the server inside the stream.
class StreamErrorEvent extends ChatStreamEvent {
  const StreamErrorEvent(this.error, {super.eventId});

  final ChatError error;
}

/// Forward-compatible fallback for event types this client does not know.
class UnknownStreamEvent extends ChatStreamEvent {
  const UnknownStreamEvent(this.raw);

  final Map<String, dynamic> raw;

  String? get eventType => raw['event_type'] as String?;
}
