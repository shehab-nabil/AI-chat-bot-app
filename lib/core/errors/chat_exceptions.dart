/// Base type for every failure surfaced by the chat request layer.
sealed class ChatException implements Exception {
  const ChatException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message';
}

/// The API answered with an error (HTTP error status or an SSE `error` event).
class ChatApiException extends ChatException {
  const ChatApiException(
    super.message, {
    this.statusCode,
    this.code,
    super.cause,
  });

  final int? statusCode;
  final String? code;
}

/// The request never produced a usable HTTP response (offline, timeout, ...).
class ChatNetworkException extends ChatException {
  const ChatNetworkException(super.message, {super.cause});
}

/// A response or stream payload was not valid JSON / not the expected shape.
class ChatParseException extends ChatException {
  const ChatParseException(super.message, {super.cause});
}

/// The SSE stream broke or ended before the interaction finished.
class ChatStreamException extends ChatException {
  const ChatStreamException(super.message, {super.cause});
}
