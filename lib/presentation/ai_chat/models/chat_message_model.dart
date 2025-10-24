class ChatMessage {
  final String text;
  final bool isFromUser;
  final bool isTyping;

  const ChatMessage({required this.text, required this.isFromUser, this.isTyping = false});

  @override
  String toString() {
    return 'ChatMessage(text: $text, isFromUser: $isFromUser, isTyping: $isTyping)';
  }
}
