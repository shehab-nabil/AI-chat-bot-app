class ChatReply {
  const ChatReply({required this.interactionId, required this.text});

  /// Pass back as `previousInteractionId` on the next turn.
  final String interactionId;
  final String text;
}
