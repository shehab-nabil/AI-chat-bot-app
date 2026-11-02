import 'chat_step_model.dart';

/// The `input` of a request: a plain string or a list of steps.
sealed class ChatInput {
  const ChatInput();

  factory ChatInput.fromJson(Object json) {
    if (json is String) return TextInput(json);
    if (json is List) {
      return StepsInput(
        json.whereType<Map<String, dynamic>>().map(ChatStep.fromJson).toList(),
      );
    }
    throw FormatException('Unsupported input: ${json.runtimeType}');
  }

  Object toJson();
}

class TextInput extends ChatInput {
  const TextInput(this.text);

  final String text;

  @override
  Object toJson() => text;
}

class StepsInput extends ChatInput {
  const StepsInput(this.steps);

  final List<ChatStep> steps;

  @override
  Object toJson() => steps.map((s) => s.toJson()).toList();
}
