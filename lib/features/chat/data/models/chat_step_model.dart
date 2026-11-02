import 'chat_content_model.dart';

List<ChatContent>? _contentList(Object? v) => (v as List?)
    ?.whereType<Map<String, dynamic>>()
    .map(ChatContent.fromJson)
    .toList();

/// One step of an interaction, discriminated by `type`.
sealed class ChatStep {
  const ChatStep();

  factory ChatStep.fromJson(Map<String, dynamic> json) {
    return switch (json['type']) {
      'user_input' => UserInputStep(_contentList(json['content'])),
      'model_output' => ModelOutputStep(_contentList(json['content'])),
      'thought' => ThoughtStep(
        signature: json['signature'] as String?,
        summary: _contentList(json['summary']),
      ),
      'function_call' => FunctionCallStep(
        id: json['id'] as String?,
        name: json['name'] as String? ?? '',
        arguments: (json['arguments'] as Map?)?.cast<String, dynamic>(),
      ),
      _ => UnknownStep(json),
    };
  }

  Map<String, dynamic> toJson();
}

/// A user turn. Use [UserInputStep.text] for the common single-text case.
class UserInputStep extends ChatStep {
  const UserInputStep(this.content);
  UserInputStep.text(String text) : content = [TextContent(text)];

  final List<ChatContent>? content;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'user_input',
    if (content != null) 'content': content!.map((c) => c.toJson()).toList(),
  };
}

class ModelOutputStep extends ChatStep {
  const ModelOutputStep(this.content);

  final List<ChatContent>? content;

  /// Concatenated text of all text blocks.
  String get text => (content ?? const <ChatContent>[])
      .whereType<TextContent>()
      .map((c) => c.text)
      .join();

  @override
  Map<String, dynamic> toJson() => {
    'type': 'model_output',
    if (content != null) 'content': content!.map((c) => c.toJson()).toList(),
  };
}

class ThoughtStep extends ChatStep {
  const ThoughtStep({this.signature, this.summary});

  final String? signature;
  final List<ChatContent>? summary;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'thought',
    if (signature != null) 'signature': signature,
    if (summary != null) 'summary': summary!.map((c) => c.toJson()).toList(),
  };
}

class FunctionCallStep extends ChatStep {
  const FunctionCallStep({this.id, required this.name, this.arguments});

  final String? id;
  final String name;
  final Map<String, dynamic>? arguments;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'function_call',
    if (id != null) 'id': id,
    'name': name,
    if (arguments != null) 'arguments': arguments,
  };
}

/// Any step type not modelled above (e.g. `function_result`, tool calls).
/// The full payload is preserved untouched.
class UnknownStep extends ChatStep {
  const UnknownStep(this.raw);

  final Map<String, dynamic> raw;

  String? get type => raw['type'] as String?;

  @override
  Map<String, dynamic> toJson() => raw;
}
