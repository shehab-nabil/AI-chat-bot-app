import 'dart:async';
import 'dart:convert';

/// One dispatched Server-Sent Event.
class SseMessage {
  const SseMessage({this.event, required this.data});

  final String? event;
  final String data;

  bool get isDone => data.trim() == '[DONE]' || event == 'done';
}

/// Parses an SSE byte stream into [SseMessage]s per the SSE spec: UTF-8
/// decoding, `data:` lines joined with `\n`, `event:` names, `:` comments
/// ignored, blank line dispatches. A trailing unterminated event is flushed
/// when the stream closes.
Stream<SseMessage> parseSse(Stream<List<int>> bytes) async* {
  String? event;
  final data = <String>[];

  SseMessage? flush() {
    if (data.isEmpty) {
      event = null;
      return null;
    }
    final msg = SseMessage(event: event, data: data.join('\n'));
    event = null;
    data.clear();
    return msg;
  }

  final lines = utf8.decoder.bind(bytes).transform(const LineSplitter());
  await for (final line in lines) {
    if (line.isEmpty) {
      final msg = flush();
      if (msg != null) yield msg;
    } else if (line.startsWith(':')) {
      continue;
    } else {
      final i = line.indexOf(':');
      final field = i < 0 ? line : line.substring(0, i);
      var value = i < 0 ? '' : line.substring(i + 1);
      if (value.startsWith(' ')) value = value.substring(1);
      if (field == 'data') {
        data.add(value);
      } else if (field == 'event') {
        event = value;
      }
    }
  }
  final msg = flush();
  if (msg != null) yield msg;
}
