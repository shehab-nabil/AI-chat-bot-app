import 'package:json_annotation/json_annotation.dart';

import 'chat_generation_config_model.dart';
import 'chat_input_model.dart';
import 'chat_tool_model.dart';

part 'chat_request_model.g.dart';

ChatInput _inputFromJson(Object json) => ChatInput.fromJson(json);
Object _inputToJson(ChatInput input) => input.toJson();
List<ChatTool>? _toolsFromJson(List<dynamic>? json) =>
    json?.whereType<Map<String, dynamic>>().map(ChatTool.fromJson).toList();
List<Map<String, dynamic>>? _toolsToJson(List<ChatTool>? tools) =>
    tools?.map((t) => t.toJson()).toList();

/// Body of `POST /v1beta/interactions`.
///
/// `system_instruction`, `tools` and `generation_config` are interaction
/// scoped: the API does not inherit them via [previousInteractionId], so
/// callers must resend them on every turn.
@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class ChatRequest {
  const ChatRequest({
    required this.model,
    required this.input,
    this.previousInteractionId,
    this.stream,
    this.store,
    this.systemInstruction,
    this.tools,
    this.generationConfig,
  });

  factory ChatRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatRequestFromJson(json);

  final String model;

  @JsonKey(fromJson: _inputFromJson, toJson: _inputToJson)
  final ChatInput input;

  /// Omitted from the JSON when null (first turn).
  final String? previousInteractionId;
  final bool? stream;
  final bool? store;
  final String? systemInstruction;

  @JsonKey(fromJson: _toolsFromJson, toJson: _toolsToJson)
  final List<ChatTool>? tools;
  final ChatGenerationConfig? generationConfig;

  /// Copy of this request flagged with [stream]; used by the data source so
  /// the caller does not have to set it consistently with the endpoint.
  ChatRequest copyWith({bool? stream}) => ChatRequest(
    model: model,
    input: input,
    previousInteractionId: previousInteractionId,
    stream: stream ?? this.stream,
    store: store,
    systemInstruction: systemInstruction,
    tools: tools,
    generationConfig: generationConfig,
  );

  Map<String, dynamic> toJson() => _$ChatRequestToJson(this);
}
