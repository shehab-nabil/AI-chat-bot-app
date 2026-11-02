// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_generation_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatGenerationConfig _$ChatGenerationConfigFromJson(
  Map<String, dynamic> json,
) => ChatGenerationConfig(
  temperature: (json['temperature'] as num?)?.toDouble(),
  seed: (json['seed'] as num?)?.toInt(),
  stopSequences: (json['stop_sequences'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  thinkingLevel: json['thinking_level'] as String?,
  thinkingSummaries: json['thinking_summaries'] as String?,
  maxOutputTokens: (json['max_output_tokens'] as num?)?.toInt(),
);

Map<String, dynamic> _$ChatGenerationConfigToJson(
  ChatGenerationConfig instance,
) => <String, dynamic>{
  'temperature': ?instance.temperature,
  'seed': ?instance.seed,
  'stop_sequences': ?instance.stopSequences,
  'thinking_level': ?instance.thinkingLevel,
  'thinking_summaries': ?instance.thinkingSummaries,
  'max_output_tokens': ?instance.maxOutputTokens,
};
