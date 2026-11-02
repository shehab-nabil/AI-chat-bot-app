import 'package:json_annotation/json_annotation.dart';

part 'chat_error_model.g.dart';

/// `{code, message}` as found in `errors[]` and in SSE `error` events.
/// HTTP error bodies (`{"error": {"code": 400, "message": ..., "status": ...}}`)
/// are parsed with [ChatError.fromHttpBody].
@JsonSerializable(includeIfNull: false, createFactory: false)
class ChatError {
  const ChatError({this.code, this.message});

  factory ChatError.fromJson(Map<String, dynamic> json) => ChatError(
    code: json['code']?.toString(),
    message: json['message'] as String?,
  );

  /// Returns null when [body] does not contain an `error` object.
  static ChatError? fromHttpBody(Object? body) {
    if (body is Map && body['error'] is Map) {
      final e = Map<String, dynamic>.from(body['error'] as Map);
      return ChatError(
        code: (e['status'] ?? e['code'])?.toString(),
        message: e['message'] as String?,
      );
    }
    return null;
  }

  final String? code;
  final String? message;

  Map<String, dynamic> toJson() => _$ChatErrorToJson(this);
}
