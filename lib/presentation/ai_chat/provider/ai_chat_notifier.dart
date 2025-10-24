import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lokapandu/common/services/analytics_manager.dart';
import 'package:lokapandu/data/mappers/chat_mapper.dart';
import 'package:lokapandu/domain/entities/chat_entity.dart';
import 'package:lokapandu/domain/repositories/chat_repository.dart';
import 'package:lokapandu/presentation/ai_chat/models/chat_message_model.dart';

class AiChatNotifier extends ChangeNotifier {
  AiChatNotifier({
    required ChatRepository repository,
    required AnalyticsManager manager,
  }) : _repository = repository,
       _manager = manager;

  final ChatRepository _repository;
  final AnalyticsManager _manager;

  final List<ChatMessage> _chats = [];
  StreamSubscription<List<Chat>>? _chatsStream;

  bool _isLoading = false;
  bool _isClearing = false;
  bool _isRetrying = false;
  int _retryCount = 0;
  static const int _maxRetries = 3;
  String? _errorMessage;

  List<ChatMessage> get chats => _chats;

  bool get isLoading => _isLoading;

  bool get isClearing => _isClearing;

  bool get isRetrying => _isRetrying;

  bool get hasError => _errorMessage != null;

  String? get errorMessage => _errorMessage;

  Future<void> loadChatHistory() async {
    _manager.trackEvent(eventName: 'LoadChatHistory');
    try {
      _manager.startTrace('LoadChatHistory');
      final initialChats = await _repository.getChatHistory();
      _chats.clear();
      if (initialChats.isEmpty) {
        _chats.add(
          ChatMessage(
            text:
                'Hai! Aku adalah asisten wisatamu. Ada yang bisa aku bantu untuk liburanmu di Bali?',
            isFromUser: false,
          ),
        );
      }
      _chats.addAll(initialChats.map((e) => e.toChatMessage()));
      _manager.setTraceMetric('ChatSize', 'AfterLoad', _chats.length);
      _manager.stopTrace('LoadChatHistory');
      notifyListeners();
    } catch (e) {
      _manager.trackError(error: '${e.runtimeType}', description: e.toString());
      _errorMessage = 'Unexpected error: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void retryConnection() {
    _retryCount = 0;
    _isRetrying = false;
    _errorMessage = null;
    _chatsStream?.cancel();
    initStream();
  }

  void initStream() {
    _manager.trackEvent(eventName: 'InitChatStream');
    _manager.startTrace('InitChatStream');
    _chatsStream = _repository.subscribeChat().listen(
      (newChats) {
        // Remove typing indicators and clear existing chats
        _chats.removeWhere((chat) => chat.isTyping);
        _chats.clear();

        // Add welcome message if no chats exist
        if (newChats.isEmpty) {
          _chats.add(
            ChatMessage(
              text:
                  'Hai! Aku adalah asisten wisatamu. Ada yang bisa aku bantu untuk liburanmu di Bali?',
              isFromUser: false,
            ),
          );
        } else {
          // Add all chats from the stream
          _chats.addAll(newChats.map((chat) => chat.toChatMessage()));
        }

        // Clear any previous error messages and reset retry counter
        _errorMessage = null;
        _retryCount = 0;
        _isRetrying = false;
        notifyListeners();
      },
      onError: (error) {
        if (_isRetrying) return;
        // Handle stream errors gracefully
        _manager.trackError(
          error: '${error.runtimeType}',
          description: 'Chat stream error: ${error.toString()}',
        );

        if (_retryCount < _maxRetries) {
          _retryCount++;
          _isRetrying = true;
          _errorMessage =
              'Koneksi terputus. Mencoba menghubungkan kembali... ($_retryCount/$_maxRetries)';
          notifyListeners();

          // Exponential backoff: 2^retryCount seconds
          final delaySeconds = Duration(seconds: 2 << (_retryCount - 1));
          Future.delayed(delaySeconds, () {
            if (_chatsStream != null) {
              _chatsStream!.cancel();
              _isRetrying = false;
              initStream(); // Retry connection
            }
          });
        } else {
          // Max retries reached
          _isRetrying = false;
          _errorMessage =
              'Koneksi gagal. Silakan periksa koneksi internet Anda dan coba lagi.';
          notifyListeners();
        }
      },
      cancelOnError: false, // Keep the stream alive for retry
    );
    _manager.setTraceMetric('ChatSize', 'AfterInit', _chats.length);
    _manager.stopTrace('InitChatStream');
  }

  Future<void> sendMessage(String userMessageText) async {
    if (userMessageText.isEmpty || _isLoading) return;
    final userMessage = ChatMessage(text: userMessageText, isFromUser: true);
    final typingIndicator = ChatMessage(
      text: '...',
      isFromUser: false,
      isTyping: true,
    );

    _chats.addAll([userMessage, typingIndicator]);
    notifyListeners();

    try {
      _manager.trackUserAction(action: 'SendMessage', category: 'Chat');
      _manager.startTrace('Generate Response');
      // generate response
      final responseText = await _repository.generateResponse(userMessageText);
      if (responseText == null) {
        _errorMessage = 'Failed to generate response.';
        return;
      }
      _manager.setTraceMetric('ResponseLength', 'Chars', responseText.length);
      _manager.stopTrace('Generate Response');

      // store response
      _manager.startTrace('Store Response');
      await _repository.storeMultipleChats([
        (message: userMessageText, isUser: true),
        (message: responseText, isUser: false),
      ]);
      _manager.setTraceMetric('ChatSize', 'AfterAdd', _chats.length);
      _manager.stopTrace('Store Response');
    } catch (e) {
      _chats.removeWhere((msg) => msg.isTyping);
      _chats.add(ChatMessage(text: 'Error!', isFromUser: false, isError: true));
      _isLoading = false;
      _errorMessage = 'Unexpected error: ${e.toString()}';
      _manager.trackError(error: '${e.runtimeType}', description: e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> clearChatHistory() async {
    try {
      _isClearing = true;
      notifyListeners();

      _manager.trackUserAction(action: 'ClearChatHistory', category: 'Chat');
      _manager.startTrace('ClearChatHistory');
      // Clear history in repository
      _manager.setTraceMetric('ChatSize', 'BeforeClear', _chats.length);
      await _repository.clearHistory();

      // Immediately clear local chats and show welcome message
      // This provides instant feedback while stream catches up
      _chats.clear();
      _manager.setTraceMetric('ChatSize', 'AfterClear', _chats.length);
      _manager.stopTrace('ClearChatHistory');
      _chats.add(
        ChatMessage(
          text:
              'Hai! Aku adalah asisten wisatamu. Ada yang bisa aku bantu untuk liburanmu di Bali?',
          isFromUser: false,
        ),
      );

      _isClearing = false;
      _errorMessage = null; // Clear any previous errors
    } catch (e) {
      _isClearing = false;
      _errorMessage = 'Unexpected error: ${e.toString()}';
      _manager.trackError(error: '${e.runtimeType}', description: e.toString());
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _chatsStream?.cancel();
    super.dispose();
  }
}
