class ChatMessage {
  final String text;
  final bool isFromUser;
  final bool isTyping;
  final bool isError;

  const ChatMessage({
    required this.text,
    required this.isFromUser,
    this.isTyping = false,
    this.isError = false,
  });

  @override
  String toString() {
    return 'ChatMessage(text: $text, isFromUser: $isFromUser, isTyping: $isTyping)';
  }
}
