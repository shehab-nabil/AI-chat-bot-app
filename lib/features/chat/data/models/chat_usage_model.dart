import 'package:json_annotation/json_annotation.dart';

part 'chat_usage_model.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class ChatUsage {
  const ChatUsage({
    this.totalInputTokens,
    this.totalCachedTokens,
    this.totalOutputTokens,
    this.totalThoughtTokens,
    this.totalToolUseTokens,
    this.totalTokens,
  });

  factory ChatUsage.fromJson(Map<String, dynamic> json) =>
      _$ChatUsageFromJson(json);

  final int? totalInputTokens;
  final int? totalCachedTokens;
  final int? totalOutputTokens;
  final int? totalThoughtTokens;
  final int? totalToolUseTokens;
  final int? totalTokens;

  Map<String, dynamic> toJson() => _$ChatUsageToJson(this);
}
