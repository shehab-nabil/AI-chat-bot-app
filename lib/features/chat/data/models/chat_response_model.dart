import 'package:json_annotation/json_annotation.dart';

import 'chat_error_model.dart';
import 'chat_step_model.dart';
import 'chat_usage_model.dart';

part 'chat_response_model.g.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum ChatStatus {
  inProgress,
  requiresAction,
  completed,
  failed,
  cancelled,
  incomplete,
  requiresContinuation,

  /// Any status string this client does not know about.
  unknown,
}

List<ChatStep>? _stepsFromJson(List<dynamic>? json) =>
    json?.whereType<Map<String, dynamic>>().map(ChatStep.fromJson).toList();

List<Map<String, dynamic>>? _stepsToJson(List<ChatStep>? steps) =>
    steps?.map((s) => s.toJson()).toList();

/// An Interaction resource (response of `POST /interactions`, and the
/// `interaction` payload of `interaction.created` / `interaction.completed`).
@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class ChatResponse {
  const ChatResponse({
    required this.id,
    this.status,
    this.model,
    this.created,
    this.updated,
    this.previousInteractionId,
    this.steps,
    this.usage,
    this.errors,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);

  /// The interaction id to pass as `previous_interaction_id` on the next turn.
  final String id;

  @JsonKey(unknownEnumValue: ChatStatus.unknown)
  final ChatStatus? status;
  final String? model;
  final DateTime? created;
  final DateTime? updated;
  final String? previousInteractionId;

  @JsonKey(fromJson: _stepsFromJson, toJson: _stepsToJson)
  final List<ChatStep>? steps;
  final ChatUsage? usage;
  final List<ChatError>? errors;

  /// Equivalent of the SDKs' `output_text`: all text of `model_output` steps.
  String get outputText => (steps ?? const <ChatStep>[])
      .whereType<ModelOutputStep>()
      .map((s) => s.text)
      .join();

  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);
}
