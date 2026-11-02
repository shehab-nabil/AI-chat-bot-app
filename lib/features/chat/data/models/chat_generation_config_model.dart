import 'package:json_annotation/json_annotation.dart';

part 'chat_generation_config_model.g.dart';

@JsonSerializable(includeIfNull: false, fieldRename: FieldRename.snake)
class ChatGenerationConfig {
  const ChatGenerationConfig({
    this.temperature,
    this.seed,
    this.stopSequences,
    this.thinkingLevel,
    this.thinkingSummaries,
    this.maxOutputTokens,
  });

  factory ChatGenerationConfig.fromJson(Map<String, dynamic> json) =>
      _$ChatGenerationConfigFromJson(json);

  final double? temperature;
  final int? seed;
  final List<String>? stopSequences;
  final String? thinkingLevel;
  final String? thinkingSummaries;
  final int? maxOutputTokens;

  Map<String, dynamic> toJson() => _$ChatGenerationConfigToJson(this);
}
