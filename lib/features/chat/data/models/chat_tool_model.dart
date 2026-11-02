/// A tool declaration, e.g. `{"type": "google_search"}` or a `function` with
/// `name` / `description` / `parameters`. [params] holds the type-specific keys.
class ChatTool {
  const ChatTool(this.type, [this.params = const {}]);

  const ChatTool.googleSearch() : this('google_search');

  factory ChatTool.fromJson(Map<String, dynamic> json) {
    final params = Map<String, dynamic>.of(json)..remove('type');
    return ChatTool(json['type'] as String? ?? '', params);
  }

  final String type;
  final Map<String, dynamic> params;

  Map<String, dynamic> toJson() => {'type': type, ...params};
}
