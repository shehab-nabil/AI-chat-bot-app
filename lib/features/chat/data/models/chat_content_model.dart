/// A content block inside a step. Only `text` is typed; other documented
/// blocks (image, audio, video, document) are preserved as [UnknownContent].
sealed class ChatContent {
  const ChatContent();

  factory ChatContent.fromJson(Map<String, dynamic> json) {
    return switch (json['type']) {
      'text' => TextContent(
        json['text'] as String? ?? '',
        annotations: (json['annotations'] as List?)
            ?.whereType<Map<String, dynamic>>()
            .toList(),
      ),
      _ => UnknownContent(json),
    };
  }

  Map<String, dynamic> toJson();
}

class TextContent extends ChatContent {
  const TextContent(this.text, {this.annotations});

  final String text;
  final List<Map<String, dynamic>>? annotations;

  @override
  Map<String, dynamic> toJson() => {
    'type': 'text',
    'text': text,
    if (annotations != null) 'annotations': annotations,
  };
}

class UnknownContent extends ChatContent {
  const UnknownContent(this.raw);

  final Map<String, dynamic> raw;

  String? get type => raw['type'] as String?;

  @override
  Map<String, dynamic> toJson() => raw;
}
