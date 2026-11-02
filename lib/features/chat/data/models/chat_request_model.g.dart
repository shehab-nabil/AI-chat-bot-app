// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRequest _$ChatRequestFromJson(Map<String, dynamic> json) => ChatRequest(
  model: json['model'] as String,
  input: _inputFromJson(json['input'] as Object),
  previousInteractionId: json['previous_interaction_id'] as String?,
  stream: json['stream'] as bool?,
  store: json['store'] as bool?,
  systemInstruction: json['system_instruction'] as String?,
  tools: _toolsFromJson(json['tools'] as List?),
  generationConfig: json['generation_config'] == null
      ? null
      : ChatGenerationConfig.fromJson(
          json['generation_config'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$ChatRequestToJson(ChatRequest instance) =>
    <String, dynamic>{
      'model': instance.model,
      'input': _inputToJson(instance.input),
      'previous_interaction_id': ?instance.previousInteractionId,
      'stream': ?instance.stream,
      'store': ?instance.store,
      'system_instruction': ?instance.systemInstruction,
      'tools': ?_toolsToJson(instance.tools),
      'generation_config': ?instance.generationConfig,
    };
