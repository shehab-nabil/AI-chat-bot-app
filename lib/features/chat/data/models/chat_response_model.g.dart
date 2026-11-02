// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) => ChatResponse(
  id: json['id'] as String,
  status: $enumDecodeNullable(
    _$ChatStatusEnumMap,
    json['status'],
    unknownValue: ChatStatus.unknown,
  ),
  model: json['model'] as String?,
  created: json['created'] == null
      ? null
      : DateTime.parse(json['created'] as String),
  updated: json['updated'] == null
      ? null
      : DateTime.parse(json['updated'] as String),
  previousInteractionId: json['previous_interaction_id'] as String?,
  steps: _stepsFromJson(json['steps'] as List?),
  usage: json['usage'] == null
      ? null
      : ChatUsage.fromJson(json['usage'] as Map<String, dynamic>),
  errors: (json['errors'] as List<dynamic>?)
      ?.map((e) => ChatError.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': ?_$ChatStatusEnumMap[instance.status],
      'model': ?instance.model,
      'created': ?instance.created?.toIso8601String(),
      'updated': ?instance.updated?.toIso8601String(),
      'previous_interaction_id': ?instance.previousInteractionId,
      'steps': ?_stepsToJson(instance.steps),
      'usage': ?instance.usage,
      'errors': ?instance.errors,
    };

const _$ChatStatusEnumMap = {
  ChatStatus.inProgress: 'in_progress',
  ChatStatus.requiresAction: 'requires_action',
  ChatStatus.completed: 'completed',
  ChatStatus.failed: 'failed',
  ChatStatus.cancelled: 'cancelled',
  ChatStatus.incomplete: 'incomplete',
  ChatStatus.requiresContinuation: 'requires_continuation',
  ChatStatus.unknown: 'unknown',
};
