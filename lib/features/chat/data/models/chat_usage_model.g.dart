// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_usage_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUsage _$ChatUsageFromJson(Map<String, dynamic> json) => ChatUsage(
  totalInputTokens: (json['total_input_tokens'] as num?)?.toInt(),
  totalCachedTokens: (json['total_cached_tokens'] as num?)?.toInt(),
  totalOutputTokens: (json['total_output_tokens'] as num?)?.toInt(),
  totalThoughtTokens: (json['total_thought_tokens'] as num?)?.toInt(),
  totalToolUseTokens: (json['total_tool_use_tokens'] as num?)?.toInt(),
  totalTokens: (json['total_tokens'] as num?)?.toInt(),
);

Map<String, dynamic> _$ChatUsageToJson(ChatUsage instance) => <String, dynamic>{
  'total_input_tokens': ?instance.totalInputTokens,
  'total_cached_tokens': ?instance.totalCachedTokens,
  'total_output_tokens': ?instance.totalOutputTokens,
  'total_thought_tokens': ?instance.totalThoughtTokens,
  'total_tool_use_tokens': ?instance.totalToolUseTokens,
  'total_tokens': ?instance.totalTokens,
};
