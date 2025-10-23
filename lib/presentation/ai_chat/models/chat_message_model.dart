class ChatMessage {
  final String text;
  final bool isFromUser;

  const ChatMessage({required this.text, required this.isFromUser});

  @override
  String toString() {
    return 'ChatMessage(text: $text, isFromUser: $isFromUser)';
  }
}
