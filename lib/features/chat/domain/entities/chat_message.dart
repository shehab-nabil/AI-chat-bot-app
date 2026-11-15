import '../enums/chat_sender.dart';

class ChatMessage {
  const ChatMessage({required this.text, required this.sender});

  final String text;
  final ChatSender sender;
}
