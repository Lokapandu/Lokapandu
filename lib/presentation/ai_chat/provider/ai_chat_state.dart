sealed class AiChatState {
  const AiChatState();
}

final class AiChatLoading extends AiChatState {
  final String message;

  const AiChatLoading({this.message = 'Memuat data...'});
}

final class AiChatSuccess extends AiChatState {}

final class AiChatError extends AiChatState {
  final String message;
  final Object? stacktrace;

  const AiChatError({required this.message, this.stacktrace});
}
